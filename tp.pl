%Punto1
materiaPesada(Materia) :- masDe100Horas(Materia).

materiaPesada(Materia) :- esMateria(Materia,_), letrasMenorA15(Materia), not(esPromocionable(Materia)).

masDe100Horas(Materia) :- esMateria(Materia, Horas), Horas > 100.

letrasMenorA15(Materia) :- atom_length(Materia, CantidadLetras), CantidadLetras < 15.


%Punto2
esCorrelativaDe(matematicaI,matematicaII).
esCorrelativaDe(laboratorioDeComputacionI,matematicaII).

esCorrelativaDe(laboratorioDeComputacionI,laboratorioDeComputacionII).

esCorrelativaDe(laboratorioDeComputacionI,sistemasDeProcesamientoDeDatos).

esCorrelativaDe(laboratorioDeComputacionII,algoritmosI).
esCorrelativaDe(matematicaII,algoritmosI).
esCorrelativaDe(sistemasDeProcesamientoDeDatos,algoritmosI).

esCorrelativaDe(sistemasDeProcesamientoDeDatos,sistemasOperativos).
esCorrelativaDe(laboratorioDeComputacionII,sistemasOperativos).

esCorrelativaDe(matematicaII,matematicaIII).
esCorrelativaDe(laboratorioDeComputacionII,matematicaIII).

esCorrelativaDe(algoritmosI,algoritmosII).
esCorrelativaDe(matematicaIII,algoritmosII).

esCorrelativaDe(sistemasDeProcesamientoDeDatos,redesLocales).
esCorrelativaDe(sistemasOperativos,redesLocales).

esCorrelativaDe(algoritmosI,metodosNumericos).

esCorrelativaDe(algoritmosII,algoritmosIII).
esCorrelativaDe(redesLocales,algoritmosIII).

esCorrelativaDe(algoritmosII,basesDeDatos).

esCorrelativaDe(algoritmosIII,paradigmasDeProgramacion).

esCorrelativaDe(algoritmosII,seminarioDeProgramacion).
esCorrelativaDe(redesLocales,seminarioDeProgramacion).
esCorrelativaDe(metodosNumericos,seminarioDeProgramacion).

esCorrelativaDe(algoritmosIII,proyectoDeSoftware).
esCorrelativaDe(basesDeDatos,proyectoDeSoftware).

esCorrelativaDe(algoritmosIII,programacionHerramientasModernas).

%Punto2A
esMateriaInicial(Materia) :- esMateria(Materia,_), not(esCorrelativaDe(_,Materia)).

%Punto2B
hayMateriaNecesariaPara(Materia,MateriaNecesaria) :- 
    esCorrelativaDe(OtraMateria,Materia), 
    hayMateriaNecesariaPara(OtraMateria,MateriaNecesaria).

hayMateriaNecesariaPara(Materia,MateriaNecesaria) :- esCorrelativaDe(MateriaNecesaria,Materia).

%Punto2C
hayMateriaQueHabilitaA(Materia,MateriaQueHabilita) :- 
    esCorrelativaDe(Materia,OtraMateria),
    hayMateriaQueHabilitaA(OtraMateria,MateriaQueHabilita).

hayMateriaQueHabilitaA(Materia,MateriaQueHabilita) :- esCorrelativaDe(Materia,MateriaQueHabilita).

/* Punto 3-A */
materiasCursadas(Alumno,Materias) :- 
    cursada(Alumno,Materias,Nota,_),
    Nota >= 4.

materiasCursadas(Alumno,Materias) :- rindioLibre(Alumno,Materias).


/* Punto 3-B */
materiasAprobadas(Alumno,Materias) :- 
    examenFinal(Alumno,Materias,Nota),
    Nota >= 4.

materiasAprobadas(Alumno,Materias) :- 
    cursada(Alumno, Materias, Nota,_),
    promocionoMateria(Nota,Materias).

promocionoMateria(Nota, Materia) :-
    esPromocionable(Materia),
    Nota >= 7.

/* Punto 4-A */
debeFinal(Alumno, Materia) :-
    materiasCursadas(Alumno, Materia),
    not(materiasAprobadas(Alumno, Materia)).

/* Punto 4-B */
bloqueaA(Alumno, Materia1, Materia2) :-
   esCorrelativaDe(Materia1, Materia2),
   materiasCursadas(Alumno, Materia1),
   materiasCursadas(Alumno, Materia2),
   not(materiasAprobadas(Alumno, Materia1)).

/* Punto 4-C */
perdioPromocion(Alumno, Materia) :-
    cursada(Alumno, Materia, Nota,_),
    promocionoMateria(Nota, Materia),
    hayMateriaNecesariaPara(Materia, MateriaNecesaria),
    debeFinal(Alumno, MateriaNecesaria).

/* Punto 4-D */
estaAlDia(Alumno) :-
    cursada(Alumno,_,_,_),
    forall(materiasCursadas(Alumno, Materia), not(debeFinal(Alumno, Materia))).


/* Punto 5 */
%Materias
esMateria(matematicaI,96).
esMateria(matematicaII,96).
esMateria(matematicaIII,96).
esMateria(laboratorioDeComputacionI,128).
esMateria(laboratorioDeComputacionII,128).
esMateria(electricidadYMagnetismo,128).
esMateria(basesDeDatos,128).
esMateria(sistemasDeProcesamientoDeDatos,128).
esMateria(metodosNumericos,80).
esMateria(sistemasOperativos,96).
esMateria(algoritmosI,160).
esMateria(algoritmosII,144).
esMateria(algoritmosIII,160).
esMateria(redesLocales,128).
esMateria(seminarioDeProgramacion,64).
esMateria(paradigmasDeProgramacion,64).
esMateria(proyectoDeSoftware,128).
esMateria(programacionHerramientasModernas,160).

%Promocionables
esPromocionable(matematicaI).
esPromocionable(matematicaII).
esPromocionable(laboratorioDeComputacionI).
esPromocionable(laboratorioDeComputacionII).
esPromocionable(electricidadYMagnetismo).
esPromocionable(sistemasDeProcesamientoDeDatos).
esPromocionable(sistemasOperativos).
esPromocionable(paradigmasDeProgramacion).

%Cursada
cursada(pepo, matematicaI, 8, cuatrimestral(2012,1)).
cursada(pepo, electricidadYMagnetismo, 8, cuatrimestral(2012,1)).
cursada(pepo, laboratorioDeComputacionI, 8, cuatrimestral(2012,1)).
cursada(pepo, laboratorioDeComputacionII, 5, cuatrimestral(2012,2)).
cursada(pepo, matematicaII, 6, cuatrimestral(2012,2)).
cursada(pepo, matematicaIII, 4, anual(2013)).
cursada(pablito, matematicaI, 8, cuatrimestral(2013,1)).
cursada(pablito, laboratorioDeComputacionI, 10, cuatrimestral(2013,2)).
cursada(pablito, electricidadYMagnetismo, 9, verano(2014,febrero)).

cursada(pole, electricidadYMagnetismo, 7, cuatrimestral(2012,1)).
cursada(pole, matematicaI, 8, cuatrimestral(2012,1)).
cursada(pole, laboratorioDeComputacionI, 5, cuatrimestral(2012,1)).
cursada(lucas, matematicaI, 10, cuatrimestral(2013,2)).
cursada(lucas, laboratorioDeComputacionI, 5, cuatrimestral(2013,2)).
cursada(lucas, laboratorioDeComputacionII, 7, cuatrimestral(2012,2)).
cursada(nico, matematicaI, 2, cuatrimestral(2012,1)).
cursada(nico, matematicaI, 3, cuatrimestral(2012,2)).
cursada(nico, matematicaI, 9, cuatrimestral(2013,2)).
cursada(test, matematicaI, 5, cuatrimestral(2015,1)).

%RindioLibre
rindioLibre(pepo, sistemasDeProcesamientoDeDatos).
rindioLibre(lucas,electricidadYMagnetismo).

%Final
examenFinal(pepo, matematicaII, 4).
examenFinal(pepo, laboratorioDeComputacionII, 2).
examenFinal(pepo, sistemasDeProcesamientoDeDatos, 6).
examenFinal(pole, laboratorioDeComputacionI,9).

/* Parte 2 */
%PuedeCursar
%Punto1
puedeCursar(Alumno, Materia):-
    esMateria(Materia,_),
    noCursoLaMateria(Alumno, Materia),
    aproboCorrelativas(Alumno, Materia).

aproboCorrelativas(Alumno, Materia):-
    forall(hayMateriaNecesariaPara(Materia, OtraMateria), materiasCursadas(Alumno, OtraMateria)).



noCursoLaMateria(Alguien,Materia) :- not(materiasCursadas(Alguien, Materia)).

%Punto2y3
cursoEn(Alguien, Materia, Epoca) :- cursada(Alguien, Materia, _, Epoca).

materiasRecurso(Alguien, Materia) :- 
    cursoEn(Alguien, Materia, Epoca), 
    cursoEn(Alguien, Materia, OtraEpoca),
    Epoca \= OtraEpoca.


/* PUNTO 4  */

/* A */
sinDescanso(Estudiante) :-
    materiasRecurso(Estudiante,_),
    forall(materiasRecurso(Estudiante, Materia), cursoEnLaSiguienteCursada(Estudiante, Materia)).

/* CASO: MATERIAS CUATRIMESTRALES */
cursoEnLaSiguienteCursada(Estudiante, Materia) :-
    cursada(Estudiante, Materia, _, cuatrimestral(Anio, 1)),
    cursada(Estudiante, Materia, _, cuatrimestral(Anio, 2)).

cursoEnLaSiguienteCursada(Estudiante, Materia) :-
    cursada(Estudiante, Materia, _, cuatrimestral(Anio, 2)),
    cursada(Estudiante, Materia, _, cuatrimestral(OtroAnio, 1)),
    esSiguienteAnio(OtroAnio, Anio).

/* CASO: MATERIAS ANUALES */
cursoEnLaSiguienteCursada(Estudiante, Materia) :-
    cursada(Estudiante, Materia, _, anual(Anio)),
    cursada(Estudiante, Materia, _, anual(OtroAnio)),
    esSiguienteAnio(OtroAnio, Anio).

cursoEnLaSiguienteCursada(Estudiante, Materia) :-
    cursada(Estudiante, Materia, _, anual(Anio)),
    cursada(Estudiante, Materia, _, cuatrimestral(OtroAnio, 1)),
    esSiguienteAnio(OtroAnio, Anio).

/* CASO: MATERIAS DE VERANO*/
cursoEnLaSiguienteCursada(Estudiante, Materia) :-
    cursada(Estudiante, Materia, _, verano(Anio, _)),
    cursada(Estudiante, Materia, _, anual(Anio)).

cursoEnLaSiguienteCursada(Estudiante, Materia) :-
    cursada(Estudiante, Materia, _, verano(Anio, _)),
    cursada(Estudiante, Materia, _, cuatrimestral(Anio, 1)).

desaproboCursada(Nota) :- Nota < 4.

esSiguienteAnio(OtroAnio, Anio) :-
    OtroAnio is Anio +1.

/* B */

/* Indica si un estudiante nunca recursó una materia */
invicto(Estudiante) :-
    cursada(Estudiante, _, _, _),
    not(materiasRecurso(Estudiante, _)).

/* C */

/* Determina si el estudiante curso una materia de forma anual, reprobó, la volvio a cursar en el siguiente cuatrimestre de forma cuatrimestral y la promocionó */
repechaje(Estudiante, Materia) :-
    cursada(Estudiante, Materia, Nota, anual(Anio)),
    desaproboCursada(Nota),
    cursada(Estudiante, Materia, OtraNota, cuatrimestral(OtroAnio, 1)),
    esSiguienteAnio(OtroAnio, Anio),
    OtraNota >= 7.

/* D */

/* Se fija si todas las materias promocionables cursadas fueron promocionadas por un alumno */
buenasCursadas(Estudiante) :-
    cursada(Estudiante, _, _, _),
    forall(cursada(Estudiante, Materia, Nota, _), promocionoMateria(Nota, Materia)).    

/* E */

/* Identifica todos los años en los que cursó alguna materia anual o cuatrimestral y se fija que haya cursado alguna materia de verano en esos años */
seLoQueHicisteElVeranoPasado(Estudiante) :-
    cursada(Estudiante, _, _, _),
    forall(cursada(Estudiante, _, _, cuatrimestral(Anio, _)), cursoAlgunaMateriaEnVerano(Estudiante, Anio)),
    forall(cursada(Estudiante, _, _, anual(OtroAnio)), cursoAlgunaMateriaEnVerano(Estudiante, OtroAnio)).

/* Se fija si curso alguna materia en el año calendario siguiente*/
cursoAlgunaMateriaEnVerano(Estudiante, Anio) :-
    AnioVerano is Anio +1,
    cursada(Estudiante, _, _, verano(AnioVerano, _)).

/* Punto 5 */
perfil(Estudiante, seLoQueHicisteElVeranoPasado) :-
    seLoQueHicisteElVeranoPasado(Estudiante).

perfil(Estudiante, buenasCursadas) :-
    buenasCursadas(Estudiante).

perfil(Estudiante, invicto) :-
    invicto(Estudiante).

perfil(Estudiante, sinDescanso) :-
    sinDescanso(Estudiante).

perfil(Estudiante, repechaje) :-
    esMateria(Materia,_),
    repechaje(Estudiante,Materia).

tieneUnicoPerfil(Alumno):-
    perfil(Alumno, _),
    not(tieneOtroPerfil(Alumno)).
    
tieneOtroPerfil(Alumno):-
    perfil(Alumno, Perfil),
    perfil(Alumno, OtroPerfil),
    Perfil \= OtroPerfil.

/* Punto 6 */
valoracionDeCursada(Estudiante, Materia, ValoracionDeCursada) :-
    cursada(Estudiante, Materia, Nota, anual(_)),
    ValoracionDeCursada is Nota.

valoracionDeCursada(Estudiante, Materia, ValoracionDeCursada) :-
    cursada(Estudiante, Materia, Nota, cuatrimestral(_, Cuatrimestre)),
    ValoracionDeCursada is (Nota - Cuatrimestre).

valoracionDeCursada(Estudiante, Materia, ValoracionDeCursada) :-
    cursada(Estudiante, Materia, Nota, verano(Anio, Mes)),
    obtenerPuntaje(Anio, Mes, Nota, ValoracionDeCursada).

obtenerPuntaje(Anio, Mes, Nota, Puntaje) :-
    atom_length(Mes, CantidadLetras),
    0 is (CantidadLetras + Anio) mod 2,
    Puntaje is Nota.

obtenerPuntaje(Anio, Mes, Nota, Puntaje) :-
    atom_length(Mes, CantidadLetras),
    not(0 is (CantidadLetras + Anio) mod 2),
    Puntaje is Nota/2.


%Tests
:- begin_tests(cursada_universitaria).

test(electricidadYMagnetismo_es_materia) :-
	esMateria(electricidadYMagnetismo,_).

test(paradigmasDeProgramacion_tiene_una_carga_horaria_de_64) :-
	esMateria(paradigmasDeProgramacion,64).
	
test(algoritmosI_materia_pesada,nondet) :-
	materiaPesada(algoritmosI).
	
test(basesDeDatos_materia_pesada,nondet) :-
	materiaPesada(basesDeDatos).
	
test(metodosNumericos_materia_no_pesada,fail) :-
	materiaPesada(metodosNumericos).
	
test(materias_iniciales, set(Materias == [matematicaI, laboratorioDeComputacionI, electricidadYMagnetismo])) :-
		esMateriaInicial(Materias).

test(materias_necesarias_para_algoritmosI, set(MateriasNecesarias == [laboratorioDeComputacionI,matematicaI,matematicaII,laboratorioDeComputacionII,sistemasDeProcesamientoDeDatos])) :-
	hayMateriaNecesariaPara(algoritmosI,MateriasNecesarias).

test(no_hay_materias_necesarias_para_electricidadYMagnetismo,fail) :-
	hayMateriaNecesariaPara(electricidadYMagnetismo,_).

test(materias_que_habilita_algortimosI, set(MateriasQueHabilita == [algoritmosIII,algoritmosII,paradigmasDeProgramacion,proyectoDeSoftware,programacionHerramientasModernas,
                                                                    metodosNumericos,basesDeDatos,seminarioDeProgramacion])) :-
	hayMateriaQueHabilitaA(algoritmosI,MateriasQueHabilita).

/* Tests punto 8 */
test(materias_aprobadas_de_pepo, set(MateriasAprobadas == [laboratorioDeComputacionI, matematicaI, matematicaII, electricidadYMagnetismo, sistemasDeProcesamientoDeDatos])) :-
    materiasAprobadas(pepo, MateriasAprobadas).

test(pepo_no_esta_al_dia,fail) :-
    estaAlDia(pepo).
	
test(pole_esta_al_dia,nondet) :-
	estaAlDia(pole).

test(pepo_no_perdio_ninguna_promocion,fail) :-
    perdioPromocion(pepo, _).
	
test(lucas_perdio_promocion,nondet) :-
    perdioPromocion(lucas,_).
    
test(pepo_posee_matematicaIII_bloqueada_solo_por_laboratorioDeComputacionII, set(MateriasBloqueantes == [laboratorioDeComputacionII])) :-
    bloqueaA(pepo, MateriasBloqueantes, matematicaIII).  

test(pepo_no_recurso_ninguna_materia,fail) :-
    materiasRecurso(pepo, _).

/* Test Parte 2 */
test(pepo_puede_cursar_solo_algoritmosI_y_sistemasOperativos, set(MateriasQuePuedeCursar == [algoritmosI,sistemasOperativos])) :-
    puedeCursar(pepo, MateriasQuePuedeCursar).    


test(pablito_lescano_posee_perfil_buenasCursadas, nondet) :-
    buenasCursadas(pablito).	

test(pablito_lescano_posee_perfil_seLoQueHicisteElVeranoPasado, nondet) :-
    seLoQueHicisteElVeranoPasado(pablito).    

test(estudiantes_invictus, set(Estudiantes = [pepo, pablito, lucas, pole, test])) :- /* Sumamos esos tres estudiantes que usamos para otros tests y también cumplen la condición */
    invicto(Estudiantes).

test(valoracionDeCursada_de_pepo_en_laboratorioDeComputacionII_es_3, nondet) :-
    valoracionDeCursada(pepo, laboratorioDeComputacionII, ValoracionDeCursada),
    ValoracionDeCursada == 3.

test(valoracionDeCursada_de_pablito_en_electricidadYMagnetismo_es_4_coma_5, nondet) :-
    valoracionDeCursada(pablito, electricidadYMagnetismo, ValoracionDeCursada),
    ValoracionDeCursada == 4.5.

:- end_tests(cursada_universitaria).
