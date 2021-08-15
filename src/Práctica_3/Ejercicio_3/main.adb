with Ada.Text_IO, Ada.Real_Time, Pck_tareas;
use Ada.Text_IO, Ada.Real_Time, Pck_tareas;

procedure Main is
   P: Time_Span := Milliseconds(50);
   T : Time;
   type Ciclo is mod 16;
   Turno : Ciclo := 0;

begin
   T := Clock;
   loop
      T := T + P;
      delay(2.0);
      case Turno is
         when 0|4|8|12 =>
            Seguridad.S;
            Modulo_MD.MD1;
            Modulo_MD.MD2;
            Modulo_MD.MD3;
            Modulo_MD.MD4;

         when 1 =>
            Seguridad.S;
            Modulo_MD.MD5;
            Control_cs.CS1;
            Control_cs.CS2;
            Control_cs.CS3;

         when 2 =>
            Seguridad.S;
            Control_cs.CS4;
            Control_cs.CS5;

         when 3|6|7|10|11|14|15 =>
            Seguridad.S;

         when 5|9|13 =>
            Seguridad.S;
            Modulo_MD.MD5;
        end case;

   delay until(T);
   Turno := Turno + 1;
   end loop;
end Main;
