<link href="/markdown.css" rel="stylesheet"></link>
<script type='text/javascript' src='/ga.js'></script>

# Contribute a translation

## How to contribute your translation

* Fork this project on [GitHub](https://github.com/flores/yet-another-nutrient-calculator). You can make a regular old Git commit or edit an existing translation via GitHub's fancy web form.  For new translations, please feel free to edit [i18n/template.yml](https://github.com/flores/yet-another-nutrient-calculator/blob/master/i18n/template.yml).    
* Or [paste](http://contact.petalphile.com) your translation via a web form. I will credit you via the name and email address on the form.  Please let me know the language in the subject line.


## Template

Please use [calc.petalphile.com](http://calc.petalphile.com) for the context of the translations.

	units:
	  element: Element
	  ppm: ppm
	  degree: degree
	  us_gal: US gal
	  imp_gal: Imp gal
	  Liter: L
	  milliliter: mL
	  five_milliliter: tsp/caps
	  pump_bottle: pumps
	  grams: g
	  milligrams: mg
	input:
	  aquarium: My aquarium is
	  source:
	    text: using
	    diy: diy
	    commercial: premixed
	    label: fertilizers
	  diy:
	    text: I am dosing with
	    method_text: using
	    solution: a solution
	    dry: dry dosing
	  solution:
	    text: My solution container is
	    container: container
	    dose: and each dose is
	    tooltip: if you choose the result of your dose below, that's the dose that goes into this solution.
	  dosing_method:
	    text: and I am calculating for
	    target: what dose to reach a target
	    dose: the result of my dose
	    ei: The Estimative Index
	    ei_daily: EI daily
	    ei_low: EI low light/weekly
	    pps: Perpetual Preservation System
	    pmdd: PMDD
	  dose: 
	    text: I am adding
	    tooltip: you can use numbers like 1/8, 1.25, 2,50, or 3
	  target: My target is
	output:
	  dose: Your addition of %1 to your %2 aquarium adds
	  dose_solution: Your addition of %1 to your %2 container, with doses of %3 to your %4 aquarium adds 
	  target: To reach your target of %1 you will need to add %2 to your %3 aquarium to yield
	  target_solution: To reach your target of %1 you will need to add %2 to your %3 dosing container.  Add %4 of that mix to your %5 aquarium to yield
	warnings:
	  solubility: The solubility of %1 at room temperature is %2.  You should adjust your dose.
	  k3po4: K3PO4 in solution tends to raise pH due to the nature of KOH, a strong base. ray-the-pilot explains this for us gardeners <a href='http://bit.ly/ev7txA' target='_blank'>at APC</a>
	  eddha: Be aware that EDDHA will tint the water pink to red at even moderate doses.  You can check out a video of a 0.2ppm dose <a href='http://www.youtube.com/watch?v=ZCTu8ClcMKc' target='_blank'>here</a>.
	  urea: This product has some unknown percentage of N as Urea and as NO3.  The calculation and chart below works with NO3 equivalents.
	  cu: Your Cu dose is %1 % more than recommended for sensitive fish and inverts. Consider reducing your %2 dose by %3 <a href='http://y.petalphile.com/cu' target='_blank'>Read more about Cu toxicity here</a>
	chart:
	  text: Relative %1 for 
	  pmdd: PMDD
	  walstad: Walstad
	  pps: PPS-Pro
	  ei: The Estimative Index
	  user: and you
	  long_term_chart: Want to model long term effects of %1 dosing? Click %2 here!
	methods_text:  
	  ei: Classic EI depends on good CO2, good circulation, and regular water changes.  Light past moderation is not so important.
	  ei_daily: This is traditional EI reduced to daily dosing levels.
	  ei_low: This is EI scaled for once a week dosing under low light. The EI ranges below are over time for most tanks.
	  pps: We have calculated for a PPS-Pro daily dose.  The recommended range below is for a stabilized mature tank.
	  pmdd: PMDD does not dose %1. But maybe you should.
	  ada: The ADA fertilization system includes nutrient-rich substrate, while their liquid fertilizers supplement the water column until the substrate is depleted. The ADA elemental analysis is courtesy of Plantbrain/Tom Barr and is available at <a href='http://barrreport.com' target='_blank'>The Barr Report</a>
	misc:
	  calc: Yet Another Nutrient Calculator
	  restart: Start over
	  submit_button: Gimmie
	  translations: Translations
	  contribute: Contribute a translation
	  mobile_link: Mobile Site
	  noscript: This calculator requires Javascript to work correctly.
	  error: There was an error! Please only use numbers (3, 3.0, 3/4, 0,75, etc) and make sure all visible questions are answered.

Notice some stuff has placeholders (%1, %2, etc) or links (<a href...) -- please leave these in place and incorporate them into your translation. Also, please don't edit any keys (everything to the left of a colon, ':' ).

## Contributions and Examples

Ordered by the date they were contributed.

### Spanish
Spanish translation file [es.yml](https://github.com/flores/yet-another-nutrient-calculator/blob/master/i18n/es.yml) contributed by [DanielSev](http://www.barrreport.com/member.php/34196-DanielSev) and [Jorge Gonzalez](http://github.com/jagg81).

	units:
	  element: Elemento/Compuesto
	  ppm: ppm
	  degree: grado
	  us_gal: galones internacionales (USA)
	  imp_gal: galones imperiales (UK)
	  Liter: L
	  milliliter: mL
	  five_milliliter: cucharilla de té/tapón/5 ml
	  pump_bottle: pumps
	  grams: g
	  milligrams: mg
	input:
	  aquarium: Mi acuario es de
	  source:
	    text: uso fertilizantes 
	    diy: hágalo usted mismo
	    commercial: producto comercial
	    label: " "
	  diy:
	    text: Estoy añadiendo
	    method_text: usando
	    solution: disuelto en solución
	    dry: compuesto seco
	  solution:
	    text: usando un recipiente de
	    container: 
	    dose: añadiendo dosis de 
	    tooltip: Si en la lista de opciones inferior se especifica "resultados de lo que estoy añadiendo" esta será la dosis que se añada a la solución.
	  dosing_method:
	    text: y estoy calculando
	    target: dosis necesaria para alcanzar una concentración concreta
	    dose: resultados de lo que estoy añadiendo
	    ei: Método EI (Indice Estimativo)
	    ei_daily: Método EI diario
	    ei_low: Método EI para niveles bajos de luz/semanal
	    pps: Método de preservación constante (PPS)
	    pmdd: Método PMDD
	  dose: 
	    text: Estoy añadiendo
	    tooltip: Puedes usar números formateados como 1/8, 1.25, 2,50, or 3
	  target: Mi objetivo es
	output:
	  dose: Tu agregado de %1 para tu %2 acuario agregando
	  dose_solution: Tu agregado de %1 para tu %2 contenedor, con dosis de %3 para tu %4 acuario agregando
	  target: Para alcanzar un objetivo de %1 necesitaras agregar %2 de %3 en tu recipiente/acuario de 
	  target_solution: Para alcanzar un objetivo de %1 necesitaras agregar %2 de %3 en tu recipiente. Agregar %4 de esa mezcla en tu acuario de %5 
	warnings:
	  solubility: La solubilidad de %1 a temperature ambiente es %2.  Deberas ajustar tu dosis.
	  k3po4: El K3PO4 disuelto en una solución tiende a incrementar el pH debido a la naturaleza del KOH, que es una base fuerte. ray-the-pilot explica esto a sus jardineros <a href='http://bit.ly/ev7txA' target='_blank'>en APC</a>
	  eddha: Ten presente que el EDDHA puede tenir el agua de rojo incluso usando dosis moderadas.  Puede ver este video de una dosis de 0.2ppm <a href='http://www.youtube.com/watch?v=ZCTu8ClcMKc' target='_blank'>aqui</a>.
	  urea: Este producto tiene un porcentage desconocido de N como Urea y NO3.  El calculo y la tabla  de abajo funciona con equivalentes a NO3.
	  cu: Tu dosis de Cu es %1 % de la recomendada para peces sensibles e invertebrados. Puedes considerar reducir tu dosis de %2 por una de %3 <a href='http://y.petalphile.com/cu' target='_blank'>Mas información acerca de la toxicidad del Cu aqui</a>
	chart:
	  text: Concentraciones relativas %1 para los métodos 
	  pmdd: PMDD
	  walstad: Walstad
	  pps: PPS-Pro
	  ei: El Indice Estimativo
	  user: y tu dosificación
	  long_term_chart: Quieres modelar los efectos a largo plazo de tus dosis de %1? Haz Clic %2 aqui!
	methods_text:  
	  ei: El éxito del método EI depende de un buen nivel de CO2, buena circulacion, y cambios regulares de agua. La cantidad de luz pasado un cierto nivel moderado no es tan importantes.
	  ei_daily: Este es el método EI tradicional reducido a dosis diarias.
	  ei_low: Es es el método EI para acuarios con poca luz y dosificación semanal. Para la mayor parte de los tanques, los rangos de EI abajo son a lo largo del tiempo.
	  pps: Hemos calculado para una dosis diaria de PPS-Pro. El rango recomendado más abajo es para tanques maduros y estables.
	  pmdd: El método PMDD no dosifica %1. Sin embargo, quizás deberías considerar hacerlo tu.
	  ada: La fertilizacion de sistemas ADA incluye sustratos ricos en nutrientes, mientras que los fertilizantes liquidos añaden un suplemento a la columna de agua hasta que el substrato es consumido por completo. El analisis de ADA es una cortesia de Plantbrain/Tom Barr y puede ser encontrado en <a href='http://barrreport.com' target='_blank'>The Barr Report</a>
	misc:
	  calc: Una Calculadora de Nutrientes Mas
	  restart: Comenzar de nuevo
	  submit_button: Calcular
	  translations: Traducciones
	  contribute: Contribuye a las traducciones
	  mobile_link: Sitio Web para Móviles
	  noscript: Para el funcionamiento correcto de esta Calculadora web se require que Javascript este habilitado.
	  error: Hubo un error! Por favor solo use los numeros (3, 3.0, 3/4, 0,75, etc) y asegurese que todas la informacion requerida ha sido ingresada correctamente.


### Romanian
Romanian file [ro.yml](https://github.com/flores/yet-another-nutrient-calculator/blob/master/i18n/ro.yml) contributed by [Florin Ilia](https://github.com/FlorinI).

	units:
	  element: Element
	  ppm: mg/l
	  degree: grad
	  us_gal: gal SUA
	  imp_gal: gal UK
	  Liter: L
	  milliliter: mL
	  five_milliliter: linguriţe
	  pump_bottle: pompe
	  grams: g
	  milligrams: mg
	input:
	  aquarium: Acvariul meu are
	  source:
	    text: folosind
	    diy: diy
	    commercial: fertilizant 
	    label: comercial 
	  diy:
	    text: dozez
	    method_text: folosind
	    solution: o soluţie
	    dry: pulbere
	  solution:
	    text: într-un recipient de 
	    container: 
	    dose: cu doze de
	    tooltip: dacă mai jos alegi "rezultatul dozei mele", aceea e doza care se adaugă în această soluţie
	  dosing_method:
	    text: şi calculez 
	    target: ce doză ca să ajung la o ţintă
	    dose: rezultatul dozei mele
	    ei: Estimative Index
	    ei_daily: EI zilnic
	    ei_low: EI lumină scăzută/săptămânal
	    pps: Perpetual Preservation System
	    pmdd: PMDD
	  dose: 
	    text: adaug
	    tooltip: poţi folosi numere ca 1/8, 1.25, 2,50, sau 3
	  target: ţinta mea este
	output:
	  dose: Adăugarea de %1 la recipientul tău de %2 adaugă
	  dose_solution: Adăugarea de %1 la recipientul tău de %2 cu doze de %3, în acvariul de %4 adaugă 
	  target: Ca să-ţi atingi ţinta de %1 trebuie să adaugi %2 în recipientul tău de %3 ca să rezulte
	  target_solution: Ca să-ţi atingi ţinta de %1 trebuie să adaugi %2 în recipientul tău de %3.  Adaugă %4 din acest amestec în acvariul tău de %5 ca să rezulte
	warnings:
	  solubility: Solubilitatea pentru %1 la temperatura camerei este %2.  Ar trebui să-ţi ajustezi doza.
	  k3po4: K3PO4 în soluţie are tendinţa de a ridica pH-ul datorită naturii substanţei KOH, o bază puternică. ray-the-pilot explică asta pentru noi grădinarii <a href='http://bit.ly/ev7txA' target='_blank'>pe forumul APC</a>.
	  eddha: Ai grijă că EDDHA colorează apa în roz spre roşu chiar la doze moderate.  Poţi să vezi un video al unei doze de 0.2mg/l <a href='http://www.youtube.com/watch?v=ZCTu8ClcMKc' target='_blank'>aici</a>.
	  urea: Acest produs are un procent necunoscut de N ca uree şi ca NO3.  Calculul şi graficul de mai jos lucrează cu echivalent NO3.
	  cu: Doza ta de Cu este %1 % mai mare decât se recomandă pentru peşti sensibili şi nevertebrate. Gândeşte-te să reduci doza de %2 cu %3. <a href='http://y.petalphile.com/cu' target='_blank'>Mai multe detalii aici despre toxicitatea Cu.</a>
	chart:
	  text: Concentraţiile %1 relative pentru 
	  pmdd: PMDD
	  walstad: Walstad
	  pps: PPS-Pro
	  ei: Estimative Index
	  user: doza ta
	  long_term_chart: Vrei să modelezi efectele pe termen lung ale dozării %1? Apasă %2 aici!
	methods_text:  
	  ei: EI clasic depinde de dozarea bună de CO2, circulaţia bună a apei, şi schimburi regulate de apă.  Lumina peste un nivel moderat nu este aşa de importantă.
	  ei_daily: Acesta este EI tradiţional calculat pentru dozări zilnice.
	  ei_low: Acesta este EI scalat pentru dozare o dată pe săptămână la lumină slabă. Majoritatea acvariilor dozate cu EI parcurg intervalele EI de mai jos, în timp.
	  pps: Am calculat pentru o doză PPS zilnică.  Intervalul recomandat de mai jos este pentru un acvariu matur, stabilizat.
	  pmdd: PMDD nu dozează %1. Dar poate tu ar trebui.
	  ada: Sistemul de fertilizare ADA include substrat bogat în nutrienţi, iar fertilizanţii lor lichizi suplimentează coloana de apă până când substratul este epuizat. Analiza elementară a ADA este oferită de Plantbrain/Tom Barr şi este disponibilă pe <a href='http://barrreport.com' target='_blank'>The Barr Report</a>.
	misc:
	  calc: Yet Another Nutrient Calculator
	  restart: De la început
	  submit_button: Dă-mi!
	  translations: Traduceri
	  contribute: Adaugă o traducere
	  mobile_link: Site-ul mobil
	  noscript: Acest calculator are nevoie de Javascript ca să funcţioneze corect.
	  error: Am întâlnit o eroare! Te rog foloseşte doar numere (3, 3.0, 3/4, 0,75, etc) şi asigură-te că ai răspuns la toate întrebările vizibile.

### Dutch

Dutch translation file [nl.yml](https://github.com/flores/yet-another-nutrient-calculator/blob/master/i18n/nl.yml) contributed by [dutchy](http://www.barrreport.com/member.php/21013-dutchy).

### German

German translation file [de.yml](https://github.com/flores/yet-another-nutrient-calculator/blob/master/i18n/de.yml) contributed by [WasserPest](https://github.com/wasserpest)

### Japanese

Japanese translation file [ja.yml](https://github.com/flores/yet-another-nutrient-calculator/blob/master/i18n/ja.yml) contributed by [Tyler Merritt](https://github.com/tgmerritt)

### Brazilian Portuguese

Brazilian Portuguese file [pt-br.yml](https://github.com/flores/yet-another-nutrient-calculator/blob/master/i18n/pt-br.yml) contributed by [Carlos Olivera](https://github.com/oliveiracarlos).  This translation is also an example of using HTML escape codes in your translation.

### Italian

Italian translation [it.yml](https://github.com/flores/yet-another-nutrient-calculator/blob/master/i18n/it.yml) contributed by [rickertikari](https://github.com/rickertikari)

### Lithuanian

Lithuanian translation [lt.yml](https://github.com/flores/yet-another-nutrient-calculator/blob/master/i18n/lt.yml) contributed by Tautvilas.

## Goals

The goal here is to ambitiously build the best nutrient calculators for our hobby, ever.  Unlike other projects, these calculators are open source and will be improved long after any individual or site is gone from the hobby.  This calculator, with your help, will always be updated and improved upon over the years.


# Thanks!

