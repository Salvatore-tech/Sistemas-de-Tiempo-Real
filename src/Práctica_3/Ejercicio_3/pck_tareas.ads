with Ada.Real_Time;
use Ada.Real_Time;
package Pck_tareas is
   task Control_cs is
      pragma Priority(1);
      entry CS1;
      entry CS2;
      entry CS3;
      entry CS4;
      entry CS5;
   end control_cs;
   
   task Modulo_MD is
      pragma Priority(2);
      entry MD1;
      entry MD2;
      entry MD3;
      entry MD4;
      entry MD5;
   end Modulo_MD;
   
   task Seguridad is 
      pragma Priority(3);
      entry S;
   end Seguridad;   
end Pck_tareas;
