with ada.Real_Time, ada.Text_IO, Ada.Float_Text_IO;
use ada.Real_Time, Ada.Text_IO, Ada.Float_Text_IO;

package body pck_tarea_p is
   C_Pantalla: Time_Span := Milliseconds(6);
   C_Almacenamiento: Time_Span := Milliseconds(6);
   C_Tarj_Lect: Time_Span := Milliseconds(6);
   C_Tarj_Escr: Time_Span := Milliseconds(10);
   P_S: Time_Span := Milliseconds(50);
   P_MD: Time_Span := Milliseconds(200);
   P_CS: Time_Span := Milliseconds(800);
   
   task body Pantalla is 
   begin
      loop
         select   
            accept Imprimir (S1 : in NewFloat) do
               Put_Line(S1'Image);
            end Imprimir;
         or
            terminate;
         end select;
      end loop;
   end Pantalla;

   protected body Base_datos is
      entry Almacenamiento(sens_value: NewFloat) when not busy is
      begin
         busy := True;
         Open(bd, Out_File, "C:\GNAT\2020\bin\Test\src\base_datos.txt");
         Set_Output(bd);
         Ada.Float_Text_IO.Put(Float(sens_value));
         Close(bd); 
      end Almacenamiento;
      
      procedure Release_bd is 
      begin
         busy := False;
      end Release_bd;
   end Base_datos;

   task body Tarjeta is
      Data : NewFloat := 0.0;
   begin
      loop
         select
            accept Lectura(Value: out NewFloat) do
               Value := 15.0;
            end Lectura;
         or
            accept Escritura(Value: NewFloat) do
               Data := Value;
            end Escritura;
         or 
            terminate;
         end select;
      end loop;
   end Tarjeta;

   task body Control_CS is
      sens_value : NewFloat;
      new_sens_value : NewFloat;
      Inicio: Time;
   begin
      Inicio := Clock;
      Inicio := Inicio + P_CS;
         
      select 
         delay (To_Duration(C_Tarj_Lect));
      then abort
         Put_Line("Tarea CS: leyendo tarjeta...");
         Tarjeta.Lectura(sens_value);
      end select;
         
      select
         delay(To_Duration(C_accion_ctrl));
      then abort
         Put_Line("Tarea CS: calculo acción de control");
         new_sens_value := 12.0;
      end select;
         
         
      select 
         delay (To_Duration(C_Tarj_Escr));
      then abort
         Put_Line("Tarea CS: escribiendo en la tarjeta");
         Tarjeta.Escritura(new_sens_value);
      end select; 
            
      select 
         delay (To_Duration(C_Almacenamiento));
      then abort
         Put_Line("Tarea CS: almacenando en bd...");
         Base_datos.Almacenamiento(new_sens_value);
         Base_datos.Release_bd;
      end select; 
         
      select 
         delay (To_Duration(C_Pantalla));
      then abort
         Put_Line("Tarea CS: imprimiendo por pantalla...");
         Pantalla.Imprimir(new_sens_value);
      end select; 
         
      delay until(Inicio); 
   end Control_CS;
   
   task body Modulo_MD is
      sens_value : NewFloat;
      new_sens_value : NewFloat;
      Inicio : Time;
   begin
      Inicio := Clock;
      for i in 1..4 loop    
         Inicio := Inicio + P_MD;
         select 
            delay (To_Duration(C_Tarj_Lect));
         then abort
            Put_Line("Tarea MD: leyendo tarjeta...");
            Tarjeta.Lectura(sens_value);
         end select;
         
         select
            delay(To_Duration(C_accion_ctrl));
         then abort
            Put_Line("Tarea MD: calculo acción de control...");
            new_sens_value := 12.0;
         end select;
         
         select 
            delay (To_Duration(C_Tarj_Escr));
         then abort
            Put_Line("Tarea MD: escribiendo en tarjeta...");
            Tarjeta.Escritura(new_sens_value);
         end select; 
            
         select 
            delay (To_Duration(C_Almacenamiento));
         then abort
            Put_Line("Tarea MD: almacenando en bd...");
            Base_datos.Almacenamiento(new_sens_value);
            Base_datos.Release_bd;
         end select; 
         
         select 
            delay (To_Duration(C_Pantalla));
         then abort
            Put_Line("Tarea MD: imprimiendo por pantalla...");
            Pantalla.Imprimir(new_sens_value);
         end select; 
         delay until (Inicio);
      end loop;
   end Modulo_MD;

   task body Seguridad is
      sens_value : NewFloat;
      Inicio : Time;
   begin
      Inicio := Clock;
      for i in 1..16 loop
         Inicio := Inicio + P_S;
         select 
            delay (To_Duration(C_Tarj_Lect));
         then abort
            Put_Line("Tarea S: leyendo tarjeta...");
            Tarjeta.Lectura(sens_value);
         end select;
      
         select
            delay(To_Duration(C_accion_ctrl));
         then abort
            Put_Line("Tarea S: comprobando limites de seguridad...");
         end select;
      
         select 
            delay (To_Duration(C_Almacenamiento));
         then abort
            Put_Line("Tarea S: almacenando en bd...");
            Base_datos.Almacenamiento(sens_value);
            Base_datos.Release_bd;
         end select;
         select 
            delay (To_Duration(C_Pantalla));
         then abort
            Put_Line("Tarea S: imprimiendo por pantalla...");
            Pantalla.Imprimir(sens_value);
         end select; 
         delay until (Inicio);
      end loop;
   end Seguridad;
end pck_tarea_p;
