<link href="/markdown.css" rel="stylesheet"></link>

# Contribute a translation

## Template

Please use [alpha.calc.petalphile.com](http://alpha.calc.petalphile.com) for the context of the translations.

	units:
	  element: Element
	  ppm: ppm
	  degree: degree
	  us_gal: US gal
	  imp_gal: Imp gal
	  Liter: L
	  milliliter: mL
	  five_milliter: tsp/caps
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
	    text: while using a
	    container: container
	    dose: with doses of
	  dosing_method:
	    text: and I am calculating for
	    target: what dose to reach a target
	    dose: the result of my dose
	    ei: The Estimative Index
	    ei_daily: EI daily
	    ei_low: EI low light/weekly
	    pps: Perpetual Preservation System
	    pmdd: PMDD
	  dose: I am adding
	  target: My target is
	output:
	  dose: Your addition of %1 to your 
	  dose_solution: container, with doses of %1 to your
	  dose_end: aquarium adds 
	  target: To reach your target of %1 you will need to add %2 of %3 to your 
	  target_solution: container.  Add %1 of that mix to your
	  target_end: aquarium to yield
	warnings:
	  solubility: The solubility of %1 at room temperature is %2.  You should adjust your dose.
	  k3po4: K3PO4 in solution tends to raise pH due to the nature of KOH, a strong base. ray-the-pilot explains this for us gardeners <a href='http://bit.ly/ev7txA' target='_blank'>at APC</a>
	  eddha: Be aware that EDDHA will tint the water pink to red at even moderate doses.  You can check out a video of a 0.2ppm dose <a href='http://www.youtube.com/watch?v=ZCTu8ClcMKc' target='_blank'>here</a>.
	  urea: This product has some unknown percentage of N as Urea and as NO3.  The calculation and chart below works with NO3 equivalents.
	  cu: Your Cu dose is %1 % more than recommended for sensitive fish and inverts. Consider reducing your %2 dose by %3 <a href='http://y.[petalphile.com/cu' target='_blank'>Read more about Cu toxicity here</a>
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
	  ada: The ADA fertilization system includes nutrient-rich substrate, while their liquid fertilizers supplement the water column until the substrate is depeleted. The ADA elemental analysis is courtesy of Plantbrain/Tom Barr and is available at <a href='http://barrreport.com' target='_blank'>The Barr Report</a>
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

## Examples

### Spanish
Spanish translation file contributed by [jagg81](http://github.com/jagg81).

	units:
	  element: Elemento
	  ppm: ppm
	  degree: grado
	  us_gal: US gal
	  imp_gal: Imp gal
	  Liter: L
	  milliliter: mL
	  five_milliter: tsp/caps
	  pump_bottle: pumps
	  grams: g
	  milligrams: mg
	input:
	  aquarium: Mi acuario es de
	  source:
	    text: usando
	    diy: diy
	    commercial: pre-mezclado de
	    label: fertilizantes
	  diy:
	    text: Estoy cultivando
	    method_text: usando
	    solution: una solution
	    dry: cultivo seco
	  solution:
	    text: usando un
	    container: contenedor
	    dose: con porciones de
	  dosing_method:
	    text: y estoy calculando
	    target: dosis para alcanzar
	    dose: los resultados de mi cultivo
	    ei: El inidice de estimaciones
	    ei_daily: EI diario
	    ei_low: EI suave/semanal
	    pps: Sistema de preservation constante
	    pmdd: PMDD
	  dose: Estoy agregando
	  target: My objetivo es
	output:
	  dose: Tu agregado de %1 para tu
	  dose_solution: contenedor, con dosis de %1 para tu
	  dose_end: acuario agregando
	  target: para alcanzar un objetivo de %1 necesitaras agregar %2 de %3 para tu 
	  target_solution: contenedor.  Agregar %1 de esa mezcla para tu
	  target_end: acuario
	warnings:
	  solubility: La solubilidad de %1 a temperature ambiente es %2.  Deberas ajustar tu dosis.
	  k3po4: K3PO4 en solution tiende a incrementar el pH debido a la naturaleza de KOH, con una base fuerte. ray-the-pilot exaplica esto a sus jardineros <a href='http://bit.ly/ev7txA' target='_blank'>en APC</a>
	  eddha: Ten presente que EDDHA puede tenir el agua de rojo inclusive usando dosis moderadas.  Puede ver este video de una dosis de 0.2ppm <a href='http://www.youtube.com/watch?v=ZCTu8ClcMKc' target='_blank'>aqui</a>.
	  urea: Este producto tiene un porcentage desconocido de N como Urea y NO3.  El calculo y la tabla abajo funciona con equivalentes a NO3.
	  cu: Tu dosis de Cu es %1 % de la recomendada para peces sensibles e invertido. Puedes considerar reducir tu dosis de %2 por una de %3 <a href='http://y.[petalphile.com/cu' target='_blank'>Mas informacion acerca de la toxicidad del Cu aqui</a>
	chart:
	  text: Relativo %1 para 
	  pmdd: PMDD
	  walstad: Walstad
	  pps: PPS-Pro
	  ei: El inidice de estimaciones
	  user: y tu
	  long_term_chart: Quieres modelar efectos a largo plazo con dosis de %1? Haz Clic %2 aqui!
	methods_text:  
	  ei: Un EI adecuado depende de un buen CO2, buena circulacion, y cambios regulares de agua.  Moderaciones pasadas no son tan importantes.
	  ei_daily: Este EI tradicional es reducido a dosis diarias.
	  ei_low: Es es EI disenado para una onza de agua a baja luz. Para la mayor parte de los tanques, los rangos de EI abajo son a lo largo del tiempo.
	  pps: Hemos calculado para una dosis diaria de PPS-Pro. La recomendacion referida abajo es para tanques profesionales.
	  pmdd: PMDD no es una dosis %1. Pero deberias.
	  ada: La fertilizacion de sistemas ADA incluye sustratos ricos en nutrientes, mientras que los fertilizantes liquidos suplen las columnas de agua hasta que el substrato es consumido por completo. El analisis de ADA es una cortesia de Plantbrain/Tom Barr y puede ser encontrado en <a href='http://barrreport.com' target='_blank'>The Barr Report</a>
	misc:
	  calc: Una Calculadora de Nutrientes Mas
	  restart: Comenzar de nuevo
	  submit_button: Calcular
	  translations: Traducciones
	  contribute: Contribuye con las traducciones
	  mobile_link: Sitio Web para Moviles
	  noscript: Para el funcionamiento correcto de este Calculadora web se require que Javascript este habilitado.
	  error: Hubo un error! Por favor solo use los numeros (3, 3.0, 3/4, 0,75, etc) y asegurese que todas la informacion requerida a sido ingresada correctamente.

### Romanian
Romanian file contributed by [Florin Ilia](https://github.com/FlorinI).

	units:
	  element: Element
	  ppm: mg/l
	  degree: grad
	  us_gal: gal SUA
	  imp_gal: gal UK
	  Liter: L
	  milliliter: mL
	  five_milliter: linguriÅ£Äƒ
	  pump_bottle: pompe
	  grams: g
	  milligrams: mg
	input:
	  aquarium: Acvariul meu are
	  source:
	    text: folosind
	    diy: diy
	    commercial: comercial
	    label: fertilizant
	  diy:
	    text: Dozez
	    method_text: folosind
	    solution: o soluÅ£ie
	    dry: pulberi
	  solution:
	    text: folosind
	    container: container
	    dose: cu doze de
	  dosing_method:
	    text: ÅŸi calculez pentru
	    target: ce dozÄƒ ca sÄƒ ajung la o Å£intÄƒ
	    dose: rezultatul dozei mele
	    ei: Estimative Index
	    ei_daily: EI zilnic
	    ei_low: EI luminÄƒ scÄƒzutÄƒ/sÄƒptÄƒmÃ¢nal
	    pps: Perpetual Preservation System
	    pmdd: PMDD
	  dose: adaug
	  target: Å£inta mea este
	output:
	  dose: AdÄƒugarea de %1 la containerul 
	  dose_solution: tÄƒu, cu doze de %1
	  dose_end: Ã®n acvariu adaugÄƒ 
	  target: Ca sÄƒ-Å£i atingi Å£inta de %1 trebuie sÄƒ adaugi %2 %3 Ã®n 
	  target_solution: containerul tÄƒu.  AdaugÄƒ %1 din acest amestec Ã®n 
	  target_end: acvariul tÄƒu ca sÄƒ rezulte
	warnings:
	  solubility: Solubilitatea pentru %1 la temperatura camerei este %2.  Ar trebui sÄƒ-Å£i ajustezi doza.
	  k3po4: K3PO4 Ã®n soluÅ£ie are tendinÅ£a de a ridica pH-ul datoritÄƒ naturii substanÅ£ei KOH, o bazÄƒ puternicÄƒ. ray-the-pilot explicÄƒ asta pentru noi grÄƒdinarii <a href='http://bit.ly/ev7txA' target='_blank'>pe forumul APC</a>.
	  eddha: Ai grijÄƒ cÄƒ EDDHA coloreazÄƒ apa Ã®n roz spre roÅŸu chiar la doze moderate.  PoÅ£i sÄƒ vezi un video al unei doze de 0.2mg/l <a href='http://www.youtube.com/watch?v=ZCTu8ClcMKc' target='_blank'>aici</a>.
	  urea: Acest produs are un procent necunoscut de N ca uree ÅŸi ca NO3.  Calculul ÅŸi graficul de mai jos lucreazÄƒ cu echivalent NO3.
	  cu: Doza ta de Cu este %1 % mai mare decÃ¢t se recomandÄƒ pentru peÅŸti sensibili ÅŸi nevertebrate. GÃ¢ndeÅŸte-te sÄƒ reduci doza de %2 cu %3. <a href='http://y.[petalphile.com/cu' target='_blank'>Mai multe detalii aici despre toxicitatea Cu.</a>
	chart:
	  text: ConcentraÅ£iile %1 relative pentru 
	  pmdd: PMDD
	  walstad: Walstad
	  pps: PPS-Pro
	  ei: Estimative Index
	  user: doza ta
	  long_term_chart: Vrei sÄƒ modelezi efectele pe termen lung ale dozÄƒrii %1? Click %2 aici!
	methods_text:  
	  ei: EI clasic depinde de dozare bunÄƒ de CO2, circulaÅ£ie bunÄƒ a apei, ÅŸi schimburi regulate de apÄƒ.  Lumina peste un nivel moderat nu este aÅŸa de importantÄƒ.
	  ei_daily: Acesta este EI tradiÅ£ional redus la dozÄƒri zilnice.
	  ei_low: Acesta este EI scalat pentru dozare o datÄƒ pe sÄƒptÄƒmÃ¢nÄƒ la luminÄƒ slabÄƒ. Intervalele EI de mai jos sunt Ã®n timp pentru majoritatea acvariilor.
	  pps: Am calculat pentru o dozÄƒ PPS zilnicÄƒ.  Intervalul recomandat de mai jos este pentru un acvariu matur, stabilizat.
	  pmdd: PMDD nu dozeazÄƒ %1. Dar poate tu ar trebui.
	  ada: Sistemul de fertilizare ADA include substart bogat Ã®n nutrienÅ£i, iar fertilizanÅ£ii lor lichizi suplimenteazÄƒ coloana de apÄƒ pÃ¢nÄƒ cÃ¢nd substratul este epuizat. Analiza elementarÄƒ a ADA este oferitÄƒ de Plantbrain/Tom Barr ÅŸi este disponibilÄƒ pe <a href='http://barrreport.com' target='_blank'>The Barr Report</a>.
	misc:
	  calc: Yet Another Nutrient Calculator
	  restart: De la Ã®nceput
	  submit_button: DÄƒ-mi!
	  translations: Traduceri
	  contribute: AdaugÄƒ o traducere
	  mobile_link: Site-ul mobil
	  noscript: Acest calculator are nevoie de Javascript ca sÄƒ funcÅ£ioneze corect.
	  error: Am Ã®ntÃ¢lnit o eroare! Te rog foloseÅŸte doar numere (3, 3.0, 3/4, 0,75, etc) ÅŸi asigurÄƒ-te cÄƒ ai rÄƒspuns la toate Ã®ntrebÄƒrile vizibile.

## How to contribute your translation

* Fork this project on [GitHub](https://github.com/flores/yet-another-nutrient-calculator). You can either edit [i18n/template.yml](https://github.com/flores/yet-another-nutrient-calculator/blob/master/i18n/template.yml) or make a standard git commit, then make a pull request, and you will then get a public commit to this open source project.  
* [Paste](http://contact.petalphile.com) your translation via a web form. I will credit you via the name and email address on the form.

## Goals

The goal here is simply to build the best nutrient calculator for our hobby, ever.  Unlike other projects, these calculators are open source and will be around long after I or any individual site or hobbyist is gone from the hobby.  While these projects will always be free on [petalphile.com](http://petalphile.com), they have already been used in such applications as [Mistergreen's Fertilizer Calculator](http://itunes.apple.com/app/mistergreens-aquarium-fertilizer/id446259633) and [patw's Excel spreadsheet](http://www.aquaticplantenthusiasts.com/diy-projects/4322-stock-solution-spreadsheet-stocksolpro.html).  This calculator, with your help, will always be updated and improved upon over the years, forever.

## Thanks!

