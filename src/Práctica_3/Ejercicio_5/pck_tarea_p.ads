with ada.Text_IO, ada.Real_Time;
use Ada.Text_IO, Ada.Real_Time;

package pck_tarea_p is
   type NewFloat is delta 0.01 range 0.00..150.00;
   
   task Control_CS is
      pragma Priority (1);
   end Control_CS;
   
   task Modulo_MD is
      pragma Priority (2);
   end Modulo_MD;
   
   task Seguridad is 
      pragma Priority (3);
   end Seguridad;  
   
   task Tarjeta is 
      entry Lectura   (Value: out NewFloat);
      entry Escritura (Value: NewFloat);
   end Tarjeta;
   
   protected Base_datos is
      entry Almacenamiento(sens_value: NewFloat);
      procedure Release_bd;
   private
      sens_value : NewFloat := 0.0;
      busy : Boolean := False;
      bd : File_Type;
      Start: Time;
   end Base_datos;

   task Pantalla is 
      entry Imprimir(S1: NewFloat);
   end Pantalla;
end pck_tarea_p;
