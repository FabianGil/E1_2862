import excel "Base1.xls", sheet("base1") firstrow
save "base1.dta"
insheet using "Base2.csv"
save "base2.dta"
use "base1.dta", clear
append using "base2.dta", nolabel nonotes force
save "base append1y2.dta", replace
merge m:1 var1 using "base3.dta"
rename  var1 id
rename  var2 sex
rename   var3 tipodolorpecho
rename   var4 pressisto
rename   var5 colesterolserico
rename   var6 electrocardio
rename   var7 fechanacimiento
rename   var8 enfercardiac
rename var9 fechaangiogracorona
label variable id "numero de identificación"
label variable sex "femenino y masculino"
label variable tipodolorpecho "tipos de angina"
label variable pressisto "mm hg"
label variable colesterolserico "mg/dl"
label variable electrocardio "Resultados de electrocardiograma en reposo"
label variable fechanacimiento "fecha de nacimiento"
label variable enfercardiac "severidad de la enfermedad según angiografía"
label variable fechaangiogracorona "fehca angiografía"
label values sex sexo
label values tipodolorpecho tipodolorpecho
label values electrocardio resultadoselectrocardiografia
label define severidadenfermedad 0 "<50% diametro narrowing" 1 ">50% diameter narrowing"
label values enfercardiac severidadenfermedad
destring pressisto, generate(presistocontinua) force dpcomma
egen float  pressisto2 = cut( presistocontinua), at(80 90 120 140 160 189) icodes
label values pressisto2 categoriaspresiosistólica
label variable pressisto2 "niveles "
label define categoriaspresiosistólica 1 "hipotensión" 2 "normal" 3 "prehipertensión" 4 "hypertensión estado1" 5 "hipertensión estado 2" 6 "crisis"
gen  fechaangiogracorona1=date( fechaangiogracorona, "DMY")
format  fechaangiogracorona1  %d
gen   fechanacimiento1=date( fechanacimiento, "MDY")
format   fechanacimiento1  %d
gen edad= (fechaangiogracorona1- fechanacimiento1)/365
sum  sex edad,detail
tab  sex
graph box edad
tab  enfercardiac tipodolorpecho, cell
destring  colesterolserico, generate( colesterolsericocontinua) force dpcomma
