package formula_str is
   function calc_T (ST1_i, ST2_i: Float) return Float;
   function ST2_k(ST1_i, SR1_k, T_k, ST4_k: Float) return Float;
   function SD1_k(ST2_i, ST3_k: Float) return float;
   procedure parar_bombas(ST1, ST2: Float);
   procedure imprimir_file(Idx : Integer; ST1, ST2, ST3, ST4, SR1, SD1: Float);
   --Ej_3 functiones
   function SC1_optimal(SR1_k, ST1_k, ST3_k, ST4_K: float) return Float;
   function SC2_optimal(ST1_k, ST3_k: float) return Float;
   procedure comprobar_caudal(SC1_o, SC2_o: Float);
end formula_str;
