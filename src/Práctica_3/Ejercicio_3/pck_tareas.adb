with Ada.Text_IO, Ada.Real_Time;
use Ada.Text_IO, Ada.Real_Time;



package body Pck_tareas is
   C_S: Time_Span := Milliseconds(24);
   C_CS1: Time_Span := Milliseconds(6);
   C_CS2: Time_Span := Milliseconds(2);
   C_CS3: Time_Span := Milliseconds(10);
   C_CS4: Time_Span := Milliseconds(6);
   C_CS5: Time_Span := Milliseconds(6);
   C_MD1: Time_Span := Milliseconds(6);
   C_MD2: Time_Span := Milliseconds(2);
   C_MD3: Time_Span := Milliseconds(10);
   C_MD4: Time_Span := Milliseconds(6);
   C_MD5: Time_Span := Milliseconds(6);
   T_retraso: Time;
   
   task body Control_cs is
   begin
      loop
         select 
            accept CS1 do
               T_retraso := Clock;
               Put_Line("Tarea CS1: lectura tarjeta A/D");
               delay until (C_CS1 + T_retraso);
            end CS1;
         or
              
            accept CS2 do
               T_retraso := Clock;
               Put_Line("Tarea CS2: calculo acción de control");
               delay until (C_CS2 + T_retraso);
            end CS2;
         or
            accept CS3 do
               T_retraso := Clock;
               Put_Line("Tarea CS3: tarea de escritura tarjeta A/D");
               delay until(C_CS3 + T_retraso);
            end CS3;
         or
              
            accept CS4 do
               T_retraso := Clock;
               Put_Line("Tarea CS4: tarea de almacenamiento de datos");
               delay until (C_CS4 + T_retraso);
            end CS4;
         or
            accept CS5 do
               T_retraso := Clock;
               Put_Line("Tarea CS5: tarea de visualizacion por pantalla");
               delay until (C_CS5 + T_retraso);
            end CS5;
         or 
            terminate;
         end select;
      end loop;
   end Control_cs;
   
   task body Modulo_MD is
   begin
      loop
         select
               
            accept MD1 do
               T_retraso := Clock;
               Put_Line("Tarea MD1: lectura tarjeta A/D");
               delay until (C_MD1 + T_retraso);
            end MD1;
         or
                 
            accept MD2 do
               T_retraso := Clock;
               Put_Line("Tarea MD2: calculo acción de control");
               delay until (C_MD2 + T_retraso);
            end MD2;
         or
                 
            accept MD3 do
               T_retraso := Clock;
               Put_Line("Tarea MD3: tarea de escritura tarjeta A/D");
               delay until (C_MD3 + T_retraso);
            end MD3;
         or
                 
            accept MD4 do
               T_retraso := Clock;
               Put_Line("Tarea MD4: tarea de almacenamiento de datos");
               delay until (C_MD4 + T_retraso);
            end MD4;
         or
                 
            accept MD5 do
               T_retraso := Clock;
               Put_Line("Tarea MD5: tarea de visualizacion por pantalla");
               delay until (C_MD5 + T_retraso);
            end MD5;
         or
            terminate;
         end select;
      end loop;
   end Modulo_MD;
   
   task body Seguridad is 
   begin
      loop
         accept S do
            T_retraso := Clock;
            Put_Line("Tarea S: tarea de seguridad");
            delay until (C_S + T_retraso);
         end S;
      end loop;
   end Seguridad;
end Pck_tareas;
