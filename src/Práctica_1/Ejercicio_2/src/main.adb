with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;
use Ada.Float_Text_IO;
with Ada.Real_Time;
use Ada.Real_Time;
with formula_str;
use formula_str;

procedure Main is
   Input_arc, Output_arc, Output_opt: File_Type;
   Start, Finish: Time;
   Frame: Time_Span := Milliseconds(80); --Requisito temporal
   var_ST2_k: Float;
   var_ST1_k : Float;
   var_ST1_ini: Float;
   var_ST2_ini: Float := 60.0;
   var_SD1: Float;
   var_SC1_opt: Float;
   var_SC2_opt: Float;
   type Riga is
      record
         Idx : Integer := 1; -- valor por defecto
         SR1 : Float := 1.0; --valor por defecto
         ST4: Float := 1.0;
         ST3: Float := 1.0;
      end record;
   current_row: Riga;

begin
   var_ST1_ini := 50.0;
   Open(Input_arc, In_File, "C:\GNAT\2020\bin\Pratica_1\src\input.txt");
   Create(Output_arc, Out_File, "C:\GNAT\2020\bin\Pratica_1\src\data.txt");
   Create(Output_opt, Out_File, "C:\GNAT\2020\bin\Pratica_1\src\data_opt.txt");
   Set_Output(Output_arc); -- Redireccionar salida a data.txt

   while not End_Of_File(Input_arc) loop
      if End_Of_Line(Input_arc) then
         New_Line;
         Skip_Line(Input_arc);
      else
         Start := Clock; -- Starting the clock
         Get(Input_arc, current_row.Idx);
         Get(Input_arc, current_row.SR1);
         Get(Input_arc, current_row.ST4);
         Get(Input_arc, current_row.ST3);

         var_ST2_k := ST2_k(ST1_i => var_ST1_ini,
                            SR1_k => current_row.SR1,
                            T_k   => calc_T(ST1_i => var_ST1_ini, ST2_i => var_ST2_ini),
                            ST4_k => current_row.ST4);

         var_ST1_k := var_ST2_k - 10.0;

         var_SD1 := SD1_k(ST2_i => var_ST2_ini, ST3_k => current_row.ST3);
         Finish := Clock; -- Stopping the clock
         if (Finish - Start) > Frame then
            Put_Line("La tarea ha tardado demasiado tiempo");
         else
            --Set_Output(Output_arc); --Redireccionar salida a data.txt
            Set_Output(Standard_Output);
            imprimir_file(Idx => current_row.Idx,
                          ST1 => var_ST1_k,
                          ST2 => var_ST2_k,
                          ST3 => current_row.ST3,
                          ST4 => current_row.ST4,
                          SR1 => current_row.SR1,
                          SD1 => var_SD1);
            parar_bombas(ST1 => var_ST1_k, ST2 => var_ST2_k);
            Set_Output(Output_arc);
            imprimir_file(Idx => current_row.Idx,
                          ST1 => var_ST1_k,
                          ST2 => var_ST2_k,
                          ST3 => current_row.ST3,
                          ST4 => current_row.ST4,
                          SR1 => current_row.SR1,
                          SD1 => var_SD1);

         end if;

         var_ST2_ini := var_ST2_k; --Actualizar ST1(k-1) y ST2(k-1)
         var_ST1_ini := var_ST1_k;

         --Ejercicio 3: calculo de los valores optimales de los caudales SC1 y SC2
         Set_Output(Standard_Output);
         var_SC1_opt := SC1_optimal(SR1_k => current_row.SR1,
                                          ST1_k => var_ST1_k,
                                          ST3_k => current_row.ST3,
                                    ST4_K => current_row.ST4);
         var_SC2_opt := SC2_optimal(ST1_k => var_ST1_k, ST3_k => current_row.ST3);

         Put_Line(Float'Image(var_SC1_opt)& "" & Float'Image(var_SC2_opt));
         comprobar_caudal(SC1_o => var_SC1_opt, SC2_o => var_SC2_opt);
         Put_Line("");
         Set_Output(Output_opt); --Redireccionar salida a data_opt.txt
         Put_Line(Float'Image(var_SC1_opt) & "" & Float'Image(var_SC2_opt));


      end if;

   end loop;
   Close(Input_arc);
   Close(Output_arc);
   Close(Output_opt);
end Main;
