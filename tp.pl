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
cursada(test, matematicaI, 9, cuatrimestral(2013,1)).
cursada(test, matematicaII, 8, cuatrimestral(2013,2)).




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
    cursada(Estudiante, Materia, Nota, cuatrimestral(Anio, Cuatrimestre)),
    Nota < 4,
    cursada(Estudiante, Materia, _, cuatrimestral(OtroAnio, OtroCuatrimestre)),
    %% OtraNota >= 4,
    esSiguienteCuatrimestre(Anio, Cuatrimestre, OtroAnio, OtroCuatrimestre).


sinDescanso(Estudiante) :-
    cursada(Estudiante, Materia, Nota, anual(Anio)),
    Nota < 4,
    cursoEnLaSiguienteCursada(Estudiante, Materia, Anio).

sinDescanso(Estudiante) :-
    cursada(Estudiante, Materia, Nota, verano(Anio, _)),
    Nota < 4,
    cursoEnLaSiguienteCursadaDespuesDelVerano(Estudiante, Materia, Anio).


esSiguienteCuatrimestre(Anio, Cuatrimestre, OtroAnio, OtroCuatrimestre) :-
    OtroAnio is Anio,
    OtroCuatrimestre is Cuatrimestre + 1.

esSiguienteCuatrimestre(Anio, _, OtroAnio, 1) :-
    OtroAnio is Anio + 1.

cursoEnLaSiguienteCursada(Estudiante, Materia, Anio) :-
    cursada(Estudiante, Materia, OtraNota, anual(OtroAnio)),
    OtraNota >= 4,
    OtroAnio is Anio + 1.

cursoEnLaSiguienteCursada(Estudiante, Materia, Anio) :-
    cursada(Estudiante, Materia, OtraNota, cuatrimestral(OtroAnio, 1)),
    OtraNota >= 4,
    OtroAnio is Anio + 1.

/* SE PUEDE EVITAR REPETIR ESTOS DOS CON RESPECTO A LOS DOS DE ARRIBA */ /* ABSTRAER ESE OTROANIO IS ANIO +1 y IS ANIO? */

cursoEnLaSiguienteCursadaDespuesDelVerano(Estudiante, Materia, Anio) :-
    cursada(Estudiante, Materia, OtraNota, anual(OtroAnio)),
    OtraNota >= 4,
    OtroAnio is Anio.

cursoEnLaSiguienteCursadaDespuesDelVerano(Estudiante, Materia, Anio) :-
    cursada(Estudiante, Materia, OtraNota, cuatrimestral(OtroAnio, 1)),
    OtraNota >= 4,
    OtroAnio is Anio.

/* B */
invicto(Estudiante) :-
    cursada(Estudiante, _, _, _),
    not(materiasRecurso(Estudiante, _)).

/* C */
repechaje(Estudiante, Materia) :-
    cursada(Estudiante, Materia, Nota, anual(Anio)),
    Nota < 4,
    cursada(Estudiante, Materia, OtraNota, cuatrimestral(OtroAnio, 1)),
    OtroAnio is Anio + 1,
    OtraNota >= 7.

/* D */
buenasCursadas(Estudiante) :-
    cursada(Estudiante, _, _, _),
    forall(cursada(Estudiante, Materia, Nota, _), promocionoMateria(Nota, Materia)).    

/* E */
seLoQueHicisteElVeranoPasado(Estudiante) :-
    forrall(cursada(Estudiante, Materia, _, cuatrimestral(Anio,_)), cursoAlgunaMateriaEnVerano(Anio)),
    forrall(cursada(Estudiante, Materia, _, anual(OtroAnio)), cursoAlgunaMateriaEnVerano(OtroAnio)).


cursoAlgunaMateriaEnVerano(Anio) :-
    cursada(Estudiante, Materia, _, verano(Anio, _)).

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

:- end_tests(cursada_universitaria).
