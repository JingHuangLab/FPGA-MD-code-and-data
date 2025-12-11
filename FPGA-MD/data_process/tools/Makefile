board: board.c ../src/util.c ../src/data_preprocess.c  ../src/board.c
	gcc -o board board.c ../src/util.c ../src/data_preprocess.c ../src/board.c -std=c99

create_coef_table:create_coef_table.c
	gcc -o $@ $< -std=c99
md_sim: md_sim.c ../src/data_preprocess.c
	gcc -o $@ $^ ../src/multinomial.c ../src/matrix.c  ../src/board.c -lm  -std=c99 -Wno-format -Wno-incompatible-pointer-types

mdlj: mdlj.c ../src/data_preprocess.c
	gcc -o $@ $^ -lm  -std=c99 -DDEBUG=1

create_particle_file:create_particle_file.c
	gcc -o $@ $< -std=c99 -Wno-format

gen_inter_table: gen_inter_table.c ../src/multinomial.c ../src/matrix.c
	gcc -o $@ ./gen_inter_table.c ../src/multinomial.c ../src/matrix.c -DDEBUG=1 -lm -Wno-format -Wno-incompatible-pointer-types

clean:
	rm -rf example board create_coef_table example_sim  create_particle_file md_sim
