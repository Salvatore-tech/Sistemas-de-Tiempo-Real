with Ada.Text_IO;
use Ada.Text_IO;

package body formula_str is
   Beta: constant Float := 0.13;
   Leq: constant Float := 15.0;
   H: constant Float := 4.0;
   c: constant Float := 9.0*2.0*6.0*10000.0;
   Cp: constant Float := 4190.0;
   rho: constant Float := 975.0;
   SC1: constant Float := 20.0;
   SC2: constant Float := 400.0;
   ST1_ini: constant Float := 50.0;
   ST2_ini: constant Float := 60.0;
   ST2_opt: constant Float := 81.0;
   ST1_opt: constant Float := ST2_opt - 10.0;
   T_opt: constant Float := (ST1_opt + ST2_opt) / 2.0;
   SD1_opt: constant Float := 27.0;
   Temp_cri: constant Float := 95.0;
   SC1_inf_opt: constant Float := 7.5;
   SC1_sup_opt: constant Float := 20.0;
   SC2_inf_opt: constant Float := 400.0;
   SC2_sup_opt: constant Float := 600.0;
   
   
   
   function calc_T (ST1_i, ST2_i: Float) return Float is
   begin
      return (Float(ST1_i + ST2_i)/2.0);
   end calc_T;
   
   function ST2_k(ST1_i, SR1_k, T_k, ST4_k: Float) return Float is 
   begin
      return (ST1_i+((Beta * Leq * SR1_k * c) / (SC1 * Cp * rho) - (H * (T_k - ST4_k) * c) /
              (SC1 * Cp * rho)));
   end ST2_k;
   
   function SD1_k(ST2_i, ST3_k: Float) return Float is 
   begin
      return (24.0 * (0.135 + 0.003 * ST2_i - 0.0203 * ST3_k - 0.001 * SC2 + 0.00004 *
                ST2_i * SC2));
   end SD1_k;

   procedure imprimir_file(Idx : Integer; ST1, ST2, ST3, ST4, SR1, SD1: Float) is
   begin
      Put_Line(Idx'Image & "" & ST1'Image & "" & ST2'Image & "" & ST3'Image & "" & ST4'Image &
                 "" & SC1'Image & "" & SC2'Image & "" & SR1'Image & "" & SD1'Image);
   end imprimir_file;
   
   procedure parar_bombas(ST1, ST2: Float) is 
   begin
      if(ST1 <= Temp_cri) then
         Set_Output(Standard_Output);
         Put_Line("ST1 es mayor/igual de 95°C, se ha realizado una parada en la bomba 1");
      elsif (ST2 >= Temp_cri) then
         Put_Line("ST2 es mayor/igual de 95°C, se han realizado tres paradas en la bomba 2");
      end if;
   end parar_bombas;
   
   function SC1_optimal(SR1_k, ST1_k, ST3_k, ST4_K: float) return Float is 
   begin
      return ((c * Beta * Leq * SR1_k) - (c * (H * (T_opt - ST4_K)))) / (Cp * rho *
                                                                         (ST2_opt - ST1_opt));
   end SC1_optimal;
   
   function SC2_optimal(ST1_k, ST3_k: float) return Float is
   begin
      return ((SD1_opt / 24.0 - 0.135 - 0.003 * ST2_opt + 0.0203 * ST3_k) /
              (-0.001 + 0.00004 * ST2_opt));
   end SC2_optimal;
   
   
   
   procedure comprobar_caudal(SC1_o, SC2_o: Float) is 
   begin
      if(SC1_o < SC1_inf_opt or SC1_o > SC1_sup_opt) then
         Set_Output(Standard_Output);
         Put_Line("SC1 se encuentra fuera del rango [7.5, 20] => " & Float'Image(SC1_o));
      elsif (SC2_o < SC2_inf_opt or SC2_o > SC2_sup_opt) then
         Put_Line("SC2 se encuentra fuera del rango [400, 600] => " & Float'Image(SC2_o));
      end if;
   end comprobar_caudal;
end formula_str;
