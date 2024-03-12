README to dataset D010


In de bijlage mijn SPSS basis file van de resultaten van mijn studie.
Ik ben echt druk geweest met R en dat maakt mij niet een gelukkiger mens ☹.  Ik heb ook mijn script als bijlage toegevoegd en daarin aangegeven waar ik vast loop (onder #-functie).
Lukt het zo om het script in te lezen?

De belangrijkste punten voor aanstaande donderdag zijn:
Ik heb een vraag over drie variabelen (werkgeluk, werksatisfaction en werk posture), deze zijn alleen in te vullen als iemand ook daadwerkelijk werk. Daarom lijkt het of er veel NA’s zijn. Maar dat zijn ze eigenlijk niet. Hoe kunnen we hiermee omgaan?
Het maken van een uitgebreide tabel van de responders/non-responders op de verschillende variabelen. Aantallen per variabelen lukt wel. De volgende codes lopen vast:
explanatory = c ("Age", "Depression", "Duration")
dependent = "Pain_intensity"
df_select %>%
+ missing_compare(dependent, explanatory) %>%
df_select %>%
missing_compare(dependent, explanatory) %>%
knitr:: kable(row.names=FALSE, align = c ("l", "l", "r", "r", "r"), caption = "Mean comparison")
Bij de volgende codes loop ik ook vast.  ‘imp’ lijkt niet te werken in mijn R-studio. Hierdoor kon ik niet verder met een poging iets te imputeren.
imp <- mice (data, m=5, maxit=10, method="pmm", printFlag = FALSE)
imp$predictorMatrix

Ik heb ook geprobeerd modellen te maken voor mijn data (dat schijnt goed te kunnen met R), maar dat is denk ik een stap te ver om mee te starten. Eerst maar eens het imputeren en analyseren.

Ik hoop donderdag een stapje verder te komen. Alvast hartstikke bedankt voor je hulp.

