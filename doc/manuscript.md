Anthropogenic plant communities of the Iberian Atlantic ecoregion
================

# Methods

We performed all data analyses with R version 4.3.1 ([R Core Team
2023](#ref-RN5387)), using the R package ‘tidyverse’ ([Wickham et al.
2019](#ref-RN4662)) for data processing and visualization. The original
datasets, as well as R code for analysis and creation of the manuscript
can be accessed at the GitHub repository
<https://github.com/efernandezpascual/manmade>.

## Study ecoregion

We studied the anthropogenic plant communities of the Iberian Atlantic
ecoregion, i.e. the territories with a temperate climate in the
north-western Iberian Peninsula. Our study ecoregion broadly corresponds
with the Cantabrian Mixed Forests ecoregion *sensu* Olson *et al.*
([2001](#ref-RN4667)), with the Iberian part of the European Atlantic
province *sensu* Rivas-Martínez *et al.* ([2017](#ref-RN4699)) and with
the Iberian section of the Atlantic biogeographical region of the
European Environmental Agency
(<https://www.eea.europa.eu/data-and-maps/figures/biogeographical-regions-in-europe-2>).
To define in detail the study ecoregion we did a fine-scale revision of
its geographic borders at high spatial resolution using the most recent
biogeographical map of the Iberian Atlantic territories ([Fernández
Prieto et al. 2020](#ref-RN5372)). The revised Iberian Atlantic
ecoregion encompasses 79,891 km<sup>2</sup> of Portugal, Spain and
France. Its climate is temperate with average monthly temperatures
ranging from 6 to 20°C, and with total annual precipitation between
1,100 and 2,600 mm, with some areas having warm-dry summers but without
the distinctive 2-month drought of the Mediterranean climate ([Moreno et
al. 1990](#ref-RN5373)). Nonetheless, the Iberian Atlantic ecoregion is
located at the transition between the temperate and the Mediterranean
climates in southern Europe.

## Definition of anthropogenic vegetation

To define our target vegetation, we followed the definitions of
anthropogenic vegetation in the recent classification of the vegetation
of Europe by Mucina *et al.* ([2016](#ref-RN4698)). In our study area,
this potentially includes the vegetation classes *Polygono-Poetea
annuae*, *Papaveretea rhoeadis*, *Digitario sanguinalis-Eragrostietea
minoris*, *Chenopodietea*, *Sisymbrietea*, *Artemisietea vulgaris*,
*Epilobietea angustifolii* and *Bidentetea*. For a complete synthesis,
we added the class *Cymbalario-Parietarietea diffusae* included by
Mucina *et al.* ([2016](#ref-RN4698)) in the vegetation of rock crevices
and screes, since this class encompasses the vegetation of human-made
walls in our ecoregion. For the nomenclature of sintaxa we follow Mucina
*et al.* ([2016](#ref-RN4698)) for alliances and higher ranks, and
Rivas-Martínez *et al.* ([2001](#ref-RN4697)) for associations.

## Vegetation data

As vegetation data for our analyses, we obtained all vegetation relevés
(i.e. records of plant species coexisting in a given sampling plot at a
given date) from our study ecoregion that were available in SIVIM, the
Iberian and Macaronesian Vegetation Information System ([Font et al.
2012](#ref-RN5374)). These were 28,775 relevés representing all
vegetation types (i.e. anthropogenic, semi-natural and natural). Since
these relevés were sampled by different authors throughout the decades,
there was no taxonomical consistency among them, so we homogenized all
taxon names for the whole dataset. We followed the methodology applied
by Jiménez-Alfaro *et al.* ([2021](#ref-RN5375)) to the Cantabrian
Mountains, an area within the study ecoregion which includes c. 80% of
the ecoregional flora, to create a new taxonomical checklist for the
ecoregion based on the Euro+Med Plantbase ([2006](#ref-RN5044)). For
vascular plants not included in Euro+Med (e.g. several *Quercus* or
*Salix* hybrids, non-native species, etc.), as well as for bryophytes,
we followed Plants of the World Online ([POWO 2023](#ref-RN5376)). We
removed Fungi and algae. For analytical purposes, we merged taxa into
aggregates (1) when there were sets of very close species with a
difficult identification in the field (e.g. *Viola riviniana* + *V.
reichenbachiana* + *V. sylvestris* = *Viola riviniana* aggr.), (2) when
the taxon was recently separated in different taxa (e.g. *Hedera
helix* + *Hedera hibernica* + *Hedera canariensis* = *Hedera helix*
aggr.) and (3) when it was assumed that not all authors were able to
identify or recognize infraspecific taxa (e.g. all *Narcissus
pseudonarcissus* subspecies and varieties = *Narcissus pseudonarcissus*
aggr.).

For mapping purposes, we improved the geographical information of the
SIVIM relevés using a downscaling procedure. The original position of
vegetation relevés in SIVIM was recorded as 10 km x 10 km (52.2%) and 1
km x 1 km (47.8%) grid cells. We assigned more precise geographic
coordinates to these plots using the elevation recorded originally by
the authors and a digital elevation model (DEM) of the Iberian Peninsula
at 200 m grid resolution. From the original 10 km x 10 km or 1 km x 1 km
grid cell of each relevé, we (1) kept only those 200 m cells that agreed
with the relevé’s elevation (± 50 m); (2) randomly selected one of these
200 m cells; and (3) assigned to the relevé the coordinate of the 200 m
cell’s centroid, in decimal degrees. By doing this, the plots were
downscaled at higher resolution within their cells, assuming that 200 m
cells at similar elevations within the same grid cell also have similar
climatic conditions.

To identify anthropogenic relevés in the SIVIM database we followed two
complementary approaches. Fist, we used the expert system created to
classify vegetation plots into EUNIS pan-European habitat classification
types ([Chytrý et al. 2020](#ref-RN5061)). The expert system uses the
floristic composition of plots to assign them to habitat types depending
on the presence and abundance of characteristic species. We used the
habitats assigned by the expert system to retrieve plots that had been
assigned to any habitat related to the vegetation classes we had
previously defined: all habitats in the level 1 code V (vegetated
man-made habitats), plus level 3 codes R55 (lowland moist or wet
tall-herb and fern fringe) and R57 (herbaceous forest clearing
vegetation). Second, we also retrieved relevés if they had been
classified by the original authors of the relevé into any sintaxa
belonging to our target anthropogenic vegetation classes
(**Supplementary 1**). This produced an initial pool of 3,160 relevés
from SIVIM, to which we added 89 relevés of urban or peri-urban plant
communities conducted by us or extracted by us from the local literature
([Zabaleta Mendizábal 1990](#ref-RN5377); [Uría Arizaga
2020](#ref-RN5378)). After initial exploration of this dataset using
Two-Way Indicator Species Analysis (TWINSPAN) ([Roleček et al.
2009](#ref-RN5379)), we identified 652 outlier relevés which either did
not belong to the target anthropogenic classes or to the geographical
area of the ecoregion. We removed these, leaving a dataset of 2,508
relevés for the analyses of this article: 2,419 relevés from SIVIM,
originally recorded in 89 publications see (**Supplementary 2**); plus
89 relevés added by us.

## Statistical analyses

<u>Definition of target alliances and training dataset.</u> As a
previous step before classification, we prepared a revised checklist of
potential anthropogenic alliances that could be present in our study
ecoregion, based on regional sintaxonomical checklists ([Izco et al.
2000](#ref-RN5363); [Díaz González 2020](#ref-RN5008); [Gómez
2020](#ref-RN5365)) and recent revisions at the European level ([Mucina
et al. 2016](#ref-RN4698); [Preislerová et al. 2022](#ref-RN5371)).
Then, we filtered our dataset to include only those relevés which had
been assigned by the authors to any of these alliances, and used
sequential TWINSPANs to do a preliminary re-classification of these
filtered relevés, attempting to re-match the relevés into the *a priori*
defined checklist of alliances. We used 3 pseudospecies cut levels (0,
15, 25) with a minimum group size of 10 plots and Sørensen’s average
dissimilarity, and the R package ‘twinspanR’ ([Zelený
2021](#ref-RN5380)) to do the TWINSPANs. To start, we did a TWINSPAN
classification into 15 clusters, followed by separate TWINSPANS within
each cluster. This preliminary TWINSPAN allowed us to (1) validate which
alliances were present in the study ecoregion; and (2) prepare a
training dataset for semi-supervised classification (see below).

<u>Semi-supervised classification.</u> Next, we applied a
semi-supervised classification to the whole dataset. Semi-supervised
classification uses a training subset of *a priori* classified relevés
to classify a secondary subset of unclassified relevés ([De Cáceres et
al. 2010](#ref-RN5383)). Our training subset included all the relevés
that (1) had been classified by the authors of the relevé into any of
the alliances that we had validated during the previous TWINSPANs, and
(2) had also been classified by us into these alliances during our
TWINSPANs. The secondary subset included all the relevés which did not
meet these two criteria. Our goal was to refine and not to simply extend
the classification, so we applied the semi-supervised classification to
the whole dataset, i.e. we allowed relevés from the training subset to
be re-assigned to other groups during the classification. In addition,
semi-supervised classification can create new groups to place data
points that do not match the already *a priori* groups. Furthermore, we
applied a noise clustering fuzzy algorithm, which allows the relevés to
be classified either into the *a priori* groups or into a ‘noise’ group
which includes outliers and transitional relevés ([Wiser & De Cáceres
2013](#ref-RN5382)). We set the fuzziness coefficient to a low value (m
= 1) to accommodate a high number of transitional relevés; and we set
the distance to the noise class to d = 1. We performed this analysis
with the R package ‘vegclust’ ([De Cáceres et al. 2010](#ref-RN5383)).
We used pairwise PERMANOVA (with 100,000 iterations, Euclidean distances
and Holm’s p-value correction) fitted with the R package ‘RVAideMemoire’
([Herve 2023](#ref-RN5381)) to test the significant of the final
vegetation groups; and Detrended Correspondence Analysis (DCA) as
implemented in the R package ‘vegan’ ([Oksanen et al.
2022](#ref-RN5386)) to visualize the relationships between the groups.

<u>Characteristic species and EUNIS habitat regionalization.</u> We
calculated sets of characteristic species ([Chytrý et al.
2020](#ref-RN5061)) for each of the final vegetation groups. We defined
dominant species as species with more than 25% cover in at least 5% of
the relevés of the group; constant species as species with a frequency
higher than 50% in the group; and diagnostic species as species with an
‘IndVal’ value with a p-value lower than 0.05, as calculated with the R
package ‘labdsv’ ([Roberts 2016](#ref-RN2311)) using 1.000.000
iterations. Additionally, we assigned to each group a regionalized level
4 EUNIS habitat code, using already codes when they existed, and
creating new codes when not.

<u>Community traits and ecological requirements.</u> To describe the
resulting vegetation groups, we compiled a dataset of species traits and
ecological preferences for the species pool of the classified relevés.
For each species, we extracted from *Flora iberica*
([1987](#ref-RN3243)) its maximum height, its median month of flowering,
the length of the flowering period, and whether it was a neophyte or
not. From FloraVeg.EU ([2023](#ref-RN5385)) we extracted the species’
life forms and kept ‘therophyte’ and ‘geophyte’ for further analysis
since these two categories had the largest contribution to variance as
per an exploratory Principal Component Analysis (PCA) performed using
the R package ‘FactoMineR’ ([Lê et al. 2008](#ref-RN3166)). We also
extracted the ecological indicator values ([Dengler et al.
2023](#ref-RN5384)) and the disturbance indicator values ([Midolo et al.
2023](#ref-RN5101)) of each species. In the case of the ecological and
disturbance indicators, we assigned values to species lacking them by
(1) calculating weighted average values of the species with values for
each plot (weighting by species cover), and (2) assigning to the missing
species the weighted average values of the plots where they were present
(weighting by species cover). Then, for each relevé we calculated its
community-weighted mean (weighting by species cover) for each trait and
ecological preference, and explored the main axes of variation using
PCA, separately for species traits and ecological preferences.

# Results

## Overview of the classification

Our revision of the literature produced a provisional list of 38
anthropogenic vegetation alliances that could be present in the Iberian
Atlantic ecoregion (**Supplementary 3**). In our study dataset (n =
2,508 relevés), there were 2,201 relevés that had been assigned by the
authors to any of these alliances. We used these 2,201 relevés for a
preliminary re-classification based on TWINSPAN, attempting to re-match
the relevés into the *a priori* defined checklist of 38 alliances. This
procedure allowed us to validate 28 alliances as present in the
ecoregion. A total of 1,725 relevés had been classified by both the
original authors and our TWINSPAN into these alliances, and these became
our training subset for semi-supervised classification. Attempts by the
semi-supervised classification to create new groups resulted on new
groups with no ecological significance, and thus we kept the the 28
alliances as final vegetation groups (**Table 1**). Most of the
alliances had a wide distribution in the ecoregion according to our
dataset (**Figure 1**), although five of them (*Caucalidion lappulae*,
*Linario polygalifoliae-Vulpion alopecuri*, *Convolvulo
arvensis-Agropyrion repentis*, *Senecionion fluviatilis*,
*Paspalo-Agrostion semiverticillati*) had only isolated occurrences in a
few points towards the southern limit of the Iberian Atlantic
territories. The regional literature included in our dataset recognized
72 associations (**Supplementary 4**) within these alliances. The
semi-supervised classification with noise clustering resulted in the
final classification of 2,081 relevés into 28 alliances and 427 relevés
left in the noise group.

Focusing on the classified plots, the dataset included 1,167 taxa or
taxa aggregates. Of these, 101 were neophytes (i.e. 9% of the species
pool). Regarding life forms, the species pool was dominated by
hemicryptophytes (43%) and therophytes (41%). The 10 most frequent
species were *Ochlopoa annua* (621 occurences), *Urtica dioica* (592),
*Sonchus oleraceus* (540), *Stellaria media* (516), *Capsella
bursa-pastoris* (390), *Polygonum aviculare* (375), *Dactylis glomerata*
(363), *Senecio vulgaris* (332) and *Anisantha sterilis* (301).
Considering only those relevés with the most frequent plot size (20
m<sup>2</sup>, n = 256 relevés), the average species richness per plot
was 16 (minimum = 3, maximum = 37).

DCA ordination of the floristic composition of the classified relevés
(**Fig. 2**) suggested a high consistency of the vegetation classes
*Cymbalario-Parietarietea diffusae*, *Polygono-Poetea annuae*,
*Papaveretea rhoeadis*, *Digitario sanguinalis-Eragrostietea minoris*,
*Sisymbrietea* and *Bidentetea*. The alliances belonging to the two
perennial ruderal vegetation classes (*Artemisietea vulgaris* and
*Epilobietea angustifolii*) were mixed together. The winter-annual class
*Chenopodietea* also showed high heterogeneity, specially because of the
isolation of the altered dune alliance *Linario polygalifoliae-Vulpion
alopecuri*.

## Community-level traits and ecological preferences

PCA ordination of the community-weighted means of the species traits
(**Fig. 3A**) indicated that the first two axes explained 65% of the
variability. The major contributors to axis 1 (41% variance explained)
were community height, proportion of geophytes, mean month of flowering
and proportion of therophytes; it separated taller communities with more
geophytes and later flowering (classes *Artemisietea vulgaris*,
*Epilobietea angustifolii* and *Bidentetea*) from shorter communities
with more therophytes and earlier flowering (classes *Polygono-Poetea
annuae*, *Papaveretea rhoeadis* and *Sisymbrietea*). The major
contributors to axis 2 (24% variance explained) were proportion of
neophytes and width of the flowering season; it separated communities
with more neophytes and longer flowering seasons (classes *Bidentetea*,
*Digitario sanguinalis-Eragrostietea minoris* and *Polygono-Poetea
annuae*) from communities with less neophytes and shorter flowering
seasons (classes *Artemisietea vulgaris*, *Epilobietea angustifolii* and
*Chenopodietea*).

PCA ordination of the community-weighted means of the species ecological
and disturbance preferences (**Fig. 3B**) indicated that the first two
axes explained 56% of the variability. The major contributors to axis 1
(35% variance explained) were diturbance frequency, soil disturbance,
mowing frequency and light requirements; it separated communities
thriving with frequent disturbances in open situations (classes
*Polygono-Poetea annuae*, *Sisymbrietea*, *Digitario-Eragrostietea* and
*Papaveretea rhoeadis*) from communities prefering less frequent
disturbances and more shade (classes *Cymbalario-Parietarietea
diffusae*, *Epilobietea angustifolii* and *Bidentetea*). The major
contributors to axis 2 (21% variance explained) were nutrient
requirements and disturbance severity; it separated more nitrophilous
communities adapted to more severe disturbances (classes
*Digitario-Eragrostietea*, *Sisymbrietea* and *Epilobietea
angustifolii*) from less nitrophilous communities adapted to lower
intensity disturbances (classes *Cymbalario-Parietarietea diffusae*,
*Artemisietea vulgaris* and *Chenopodietea*).

## Classified anthropogenic plant communities

***Cymbalario-Parietarietea diffusae*** Chasmophytic vegetation of
human-made walls.

1.  *Galio valantiae-Parietarion judaicae* Vegetation of dry walls.
    Occupies warmer, drier and more nitriphicated situations than the
    other alliance in the class, has a shorter flowering season and is
    more adept to disturbances (**Fig. 4**). Wide distrubution in the
    ecoregion (**Fig. 1**). Diagnostic species (**Supplementary 5**):
    *Parietaria judaica* aggr., *Centranthus ruber*, *Asplenium
    trichomanes*.

2.  *Cymbalario-Asplenion* Vegetation of mesic walls. Occupies colder,
    wetter and less nitriphicated situations than the other alliance in
    the class, has a longer flowering season and is less adept to
    disturbances (**Fig. 4**). Wide distrubution in the ecoregion
    (**Fig. 1**). Diagnostic species (**Supplementary 5**): *Cymbalaria
    muralis*.

***Polygono-Poetea annuae*** Dwarf vegetation of heavily-trampled sites.

3.  *Polycarpion tetraphylli* Dwarf-annual trampled vegetation of warm
    and sunny sites. Occupies warmer, sunnier and less nitriphicated
    situations than the other alliances in the class and has an earlier
    flowering season (**Fig. 4**). Wide distrubution in the ecoregion,
    specially along the coast and in the more Mediterranean valleys of
    the interior (**Fig. 1**). Diagnostic species (**Supplementary 5**):
    *Sagina apetala*, *Plantago coronopus*, *Crassula tillaea*,
    *Spergularia marina*.

4.  *Polygono-Coronopodion* Dwarf-annual trampled vegetation of dry
    sites. Occupies colder, drier and more nitriphicated situations than
    the other alliances in the class, and has a higher proportion of
    neophytes (**Fig. 4**). Wide distrubution in the ecoregion (**Fig.
    1**). Diagnostic species (**Supplementary 5**): *Matricaria
    suaveolens*, *Polygonum aviculare*.

5.  *Saginion procumbentis* Dwarf trampled vegetation of mesic sites.
    Occupies colder, wetter and more nitriphicated situations than the
    other alliance in the class, and is less dominated by therophytes
    (**Fig. 4**). Distribution concentrated in the central part of the
    ecoregion (**Fig. 1**). Diagnostic species (**Supplementary 5**):
    *Sagina procumbens*, *Bryum argenteum*.

***Papaveretea rhoeadis*** Annual segetal vegetation of crops and
gardens.

6.  *Caucalidion lappulae* Annual segetal vegetation of cereal crops on
    base-rich soils. Adapted to more frequent and severe disturbances
    than the other alliances in the class (**Fig. 4**). Distribution
    mostly limited to the more Mediterranean valleys south of the
    Cantabrian Mountains (**Fig. 1**). Diagnostic species
    (**Supplementary 5**): *Cyanus segetum*, *Papaver rhoeas*,
    *Trifolium arvense*, *Anacyclus clavatus*, *Valerianella eriocarpa*.

7.  *Scleranthion annui* Annual segetal vegetation of cereal crops on
    base-poor soils. Occupies more acidic soils than the other alliances
    in the class, and flowers earlier (**Fig. 4**). Wide distribution in
    the ecoregion, but specially in the west, where acidic bedrocks
    dominate (**Fig. 1**). Diagnostic species (**Supplementary 5**):
    *Mibora minima*, *Rumex acetosella*.

8.  *Oxalidion europeae* Annual segetal vegetation of gardens and root
    crops. Occupies wetter, shadier and more nitriphicated situations
    than the other alliances in the class, has a longer flowering season
    and a higher proportion of neophytes (**Fig. 4**). Wide distribution
    in the ecoregion (**Fig. 1**). Diagnostic species (**Supplementary
    5**): *Stellaria media*, *Veronica persica*.

***Digitario sanguinalis-Eragrostietea minoris*** Summer-annual C4
segetal vegetation.

9.  *Spergulo arvensis-Erodion cicutariae* Summer-annual C4 segetal
    vegetation. Late-flowering alliance rich in neophytes and grasses,
    occurying in highly-distubed and nitriphicated soils (**Fig. 4**).
    Wide distribution in the ecoregion (**Fig. 1**). Diagnostic species
    (**Supplementary 5**): *Digitaria sanguinalis*, *Echinochloa
    crus-galli*, *Chenopodium album*, *Amaranthus hybridus* aggr.

***Chenopodietea*** Winter-annual ruderal vegetation.

10. *Allion triquetri* Geophyte-rich fringe vegetation. Occupies warmer
    and shadier situations than the other alliances in the class, has a
    higher proportion of geophytes and a lower proportion of
    therophytes, and is adapted to less frequent disturbances (**Fig.
    4**). Wide distribution in the ecoregion (**Fig. 1**). Diagnostic
    species (**Supplementary 5**): *Urtica membranacea*, *Smyrnium
    olusatrum*, *Tradescantia fluminensis*.

11. *Geranio pusilli-Anthriscion caucalidis* Winter-annual fringe
    vegetation. Occupies situations similar to the previous alliance,
    but in colder sites, and is dominated by therophytes instead of
    geophytes (**Fig. 4**). Mostly distributed in the more Mediterranean
    valleys south of the Cantabrian Mountains (**Fig. 1**). Diagnostic
    species (**Supplementary 5**): *Geranium lucidum*, *Anthriscus
    caucalis*.

12. *Chenopodion muralis* Low-growth winter-annual ruderal vegetation.
    Occupies colder situations than the other alliances in the class and
    more often disturbed sites, and has a longer and later flowering
    season (**Fig. 4**). Sparse occurencce throughout the ecoregion
    (**Fig. 1**). Diagnostic species (**Supplementary 5**): *Malva
    neglecta*, *Urtica urens*.

13. *Echio-Galactition tomentosae* Tall-herb winter-annual ruderal
    vegetation. Occupies drier, sunnier and less nutrient-rich
    situations than the other alliances in the class (**Fig. 4**).
    Mostly distributed in the west of the ecoregion (**Fig. 1**).
    Diagnostic species (**Supplementary 5**): *Galactites tomentosus*,
    *Coleostephus myconis*, *Anisantha rigida*.

14. *Linario polygalifoliae-Vulpion alopecuri* Ephemeral annual
    vegetation of disturbed coastal dunes. Occupies drier and more
    nutrient-poor situations than the other alliances in the class
    (**Fig. 4**) and has a high number of coastal dune species. Isolated
    occurrence in the southern coasts of the ecoregion (**Fig. 1**).
    Diagnostic species (**Supplementary 5**): *Vulpia alopecuros*,
    *Malcolmia littorea*, *Crucianella maritima*, *Artemisia campestris*
    aggr.

***Sisymbrietea*** Summer-annual ruderal vegetation.

15. *Sisymbrion officinalis* Summer-annual ruderal vegetation. Rich in
    therophytes and adapted to severe disturbances (**Fig. 4**). Wide
    distribution in the ecoregion (**Fig. 1**). Diagnostic species
    (**Supplementary 5**): *Hordeum murinum*, *Sisymbrium officinale*.

***Artemisietea vulgaris*** Perennial ruderal vegetation of dry sites.

16. *Convolvulo arvensis-Agropyrion repentis* Semiruderal grasslands.
    Occupies wetter and shadier situations than the other alliances in
    the class, and has a higher proportion of geophytes and grasses
    (**Fig. 4**). Isolated occurencce in the south of the ecoregion
    (**Fig. 1**). Diagnostic species (**Supplementary 5**): *Poa
    compressa*, *Elytrigia repens*, *Potentilla reptans*, *Valerianella
    locusta*.

17. *Carduo carpetani-Cirsion odontolepidis* Thistle ruderal vegetation
    of warm sites. Occupies warmer situations than the other thistle in
    the class (**Fig. 4**). Mostly distributed in the Cantabrian
    Mountains (**Fig. 1**). Diagnostic species (**Supplementary 5**):
    *Onopordum acanthium*.

18. *Cirsion richterano-chodati* Thistle ruderal vegetation of cold
    sites. Occupies colder situations than the other thistle alliance in
    the class (**Fig. 4**). Mostly distributed in the Cantabrian
    Mountains (**Fig. 1**). Diagnostic species (**Supplementary 5**):
    *Cirsium eriophorum*, *Carduus carpetanus*, *Carduus nutans* aggr.

19. *Dauco-Melilotion* Biennial ruderal vegetation. Occupies wetter
    situations than the two thistle alliances in the class, and has a
    higher proportion of therophytes (**Fig. 4**). Sparse occurencce
    throughout the ecoregion (**Fig. 1**). Diagnostic species
    (**Supplementary 5**): *Helminthotheca echioides*, *Daucus carota*,
    *Melilotus albus*, *Foeniculum vulgare*.

***Epilobietea angustifolii*** Perennial ruderal vegetation of mesic to
wet sites.

20. *Geo urbani-Alliarion officinalis* Low-herb short-lived semiruderal
    and fringe vegetation. Occupies shadier and less disturbed
    situations than the other alliances in the class, and has a higher
    proportion of therophytes and shorter plants (**Fig. 4**). Wide
    distribution in the ecoregion (**Fig. 1**). Diagnostic species
    (**Supplementary 5**): *Urtica dioica*.

21. *Arction lappae* Low-herb short-lived ruderal vegetation. Occupies
    sunnier and more frequently-disturbed situations than the other
    alliances in the class, and has a higher proportion of therophytes
    and shorter plants (**Fig. 4**). Distribution concentrated in the
    Cantabrian Mountains (**Fig. 1**). Diagnostic species
    (**Supplementary 5**): *Oxybasis rubra*, *Senecio duriaei*.

22. *Balloto-Conion maculati* Tall-herb perennial ruderal vegetation.
    Occupies warmer situations than the other alliances in the class
    (**Fig. 4**). Distribution concentrated in the Cantabrian Mountains
    and the east of the ecoregion (**Fig. 1**). Diagnostic species
    (**Supplementary 5**): *Sambucus ebulus*.

23. *Aegopodion podagrariae* Tall-herb perennial vegetation of forest
    margins and clearings. Occupies shadier and less disturbed
    situations than the other alliances in the class (**Fig. 4**).
    Sparse occurencce throughout the ecoregion (**Fig. 1**). Diagnostic
    species (**Supplementary 5**): *Anthriscus sylvestris*, *Heracleum
    sphondylium*, *Galium aparine*.

24. *Epilobion angustifolii* Tall-herb perennial vegetation of forest
    margins and clearings in acidic soils. Occupies colder,
    nutrient-poorer, more acidic and less disturbed situations than the
    other alliances in the class (**Fig. 4**). Distributed towards the
    west of the ecoregion (**Fig. 1**). Diagnostic species
    (**Supplementary 5**): *Epilobium angustifolium*, *Digitalis
    purpurea*, *Luzula lactea*.

25. *Cynancho-Convolvulion sepium* Tall-herb vegetation of nutrient-rich
    riparian habitats. Occupies wetter situations and less disturbed
    situations than the other alliances in the class, and has a later
    flowering season (**Fig. 4**). Dispersed throughout the ecoregion
    (**Fig. 1**). Diagnostic species (**Supplementary 5**): *Eupatorium
    cannabinum*, *Angelica sylvestris*, *Picris hieracioides*.

26. *Senecionion fluviatilis* Tall-herb vegetation of nutrient-rich
    river banks and ditches. Occupies warmer and wetter situations
    situations than the other alliances in the class, flowers later, has
    taller plants and is highly dominated by neophytes and geophytes
    (**Fig. 4**). Isolated occurence in the western coast of the
    ecoregion (**Fig. 1**). Diagnostic species (**Supplementary 5**):
    *Arundo donax*, *Silene latifolia*.

***Bidentetea*** Summer-annual pioneer vegetation of temporarily-flooded
sites.

27. *Bidention tripartitae* Summer-annual pioneer vegetation of
    temporarily-flooded sites. Occupies nutrient-richer sites than the
    other alliance in the class and has a higher proportion of
    therophytes (**Fig. 4**). Dispersed throughout the ecoregion (**Fig.
    1**). Diagnostic species (**Supplementary 5**): *Persicaria
    hydropiper*, *Bidens frondosus*, *Lythrum salicaria*.

28. *Paspalo-Agrostion semiverticillati* Summer-annual pioneer
    vegetation of temporarily-flooded and warm sites. Occupies warmer
    and wetter situations than the other alliance in the class, has a
    higher proportion of neophytes and has a longer flowering season
    (**Fig. 4**). Isolated occurrences in the south of the ecoregion
    (**Fig. 1**). Diagnostic species (**Supplementary 5**): *Paspalum
    distichum*, *Cyperus longus*, *Schoenoplectus lacustris*.

# Data availability

The original datasets, as well as R code for analysis and creation of
the manuscript can be accessed at the GitHub repository
<https://github.com/efernandezpascual/manmade>. Upon publication, a
version of record of the repository will be deposited in Zenodo.

# References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-RN5044" class="csl-entry">

2006.

</div>

<div id="ref-RN3243" class="csl-entry">

Castroviejo, S. 1987. *Flora iberica*. Real Jardín Botánico, CSIC,
Madrid.

</div>

<div id="ref-RN5061" class="csl-entry">

Chytrý, M., Tichý, L., Hennekens, S.M., Knollová, I., Janssen, J.A.M.,
Rodwell, J.S., Peterka, T., Marcenò, C., Landucci, F., Danihelka, J.,
Hájek, M., Dengler, J., Novák, P., Zukal, D., Jiménez-Alfaro, B.,
Mucina, L., Abdulhak, S., Aćić, S., Agrillo, E., Attorre, F., Bergmeier,
E., Biurrun, I., Boch, S., Bölöni, J., Bonari, G., Braslavskaya, T.,
Bruelheide, H., Campos, J.A., Čarni, A., Casella, L., Ćuk, M.,
Ćušterevska, R., De Bie, E., Delbosc, P., Demina, O., Didukh, Y., Dítě,
D., Dziuba, T., Ewald, J., Gavilán, R.G., Gégout, J.-C., Giusso del
Galdo, G.P., Golub, V., Goncharova, N., Goral, F., Graf, U., Indreica,
A., Isermann, M., Jandt, U., Jansen, F., Jansen, J., Jašková, A.,
Jiroušek, M., Kącki, Z., Kalníková, V., Kavgacı, A., Khanina, L., Yu.
Korolyuk, A., Kozhevnikova, M., Kuzemko, A., Küzmič, F., Kuznetsov,
O.L., Laiviņš, M., Lavrinenko, I., Lavrinenko, O., Lebedeva, M.,
Lososová, Z., Lysenko, T., Maciejewski, L., Mardari, C., Marinšek, A.,
Napreenko, M.G., Onyshchenko, V., Pérez-Haase, A., Pielech, R.,
Prokhorov, V., Rašomavičius, V., Rodríguez Rojo, M.P., Rūsiņa, S.,
Schrautzer, J., Šibík, J., Šilc, U., Škvorc, Ž., Smagin, V.A., Stančić,
Z., Stanisci, A., Tikhonova, E., Tonteri, T., Uogintas, D., Valachovič,
M., Vassilev, K., Vynokurov, D., Willner, W., Yamalov, S., Evans, D.,
Palitzsch Lund, M., Spyropoulou, R., Tryfon, E., & Schaminée, J.H.J.
2020. [EUNIS habitat classification: Expert system, characteristic
species combinations and distribution maps of european
habitats](https://doi.org/10.1111/avsc.12519). *Applied Vegetation
Science* 23: 648–675.

</div>

<div id="ref-RN5383" class="csl-entry">

De Cáceres, M., Font, X., & Oliva, F. 2010. [The management of
vegetation classifications with fuzzy
clustering](https://doi.org/10.1111/j.1654-1103.2010.01211.x). *Journal
of Vegetation Science* 21: 1138–1151.

</div>

<div id="ref-RN5384" class="csl-entry">

Dengler, J., Jansen, F., Chusova, O., Hüllbusch, E., Nobis, M.P., Van
Meerbeek, K., Axmanová, I., Bruun, H.H., Chytrý, M., Guarino, R.,
Karrer, G., Moeys, K., Raus, T., Steinbauer, M.J., Tichý, L., Tyler, T.,
Batsatsashvili, K., Bita-Nicolae, C., Didukh, Y., Diekmann, M.,
Englisch, T., Fernández-Pascual, E., Frank, D., Graf, U., Hájek, M.,
Jelaska, S.D., Jiménez-Alfaro, B., Julve, P., Nakhutsrishvili, G.,
Ozinga, W.A., Ruprecht, E.-K., Šilc, U., Theurillat, J.-P., & Gillet, F.
2023. [﻿Ecological indicator values for europe (EIVE)
1.0](https://doi.org/10.3897/vcs.98324). *Vegetation Classification and
Survey* 4:

</div>

<div id="ref-RN5008" class="csl-entry">

Díaz González, T.E. 2020. La vegetación del principado de asturias
(españa) (esquema sintaxonómico de las comunidades vegetales). *Boletín
de Ciencias de la Naturaleza del RIDEA* 55: 339–646.

</div>

<div id="ref-RN5372" class="csl-entry">

Fernández Prieto, J.A., Amigo, J., Bueno, Á., Herrera, M.,
Rodríguez-Guitián, M.A., & Loidi, J. 2020. Notas sobre el catálogo de
comunidades de plantas vasculares de los territorios iberoatlánticos
(i). *Naturalia Cantabricae* 17–37.

</div>

<div id="ref-RN5385" class="csl-entry">

FloraVeg.EU. 2023. FloraVeg.EU – database of european vegetation,
habitats and flora. Www.floraveg.eu. Accessed december 2023.

</div>

<div id="ref-RN5374" class="csl-entry">

Font, X., Pérez-García, N., Biurrun, I., Fernández-González, F., &
Lence, C. 2012. The iberian and macaronesian vegetation information
system (SIVIM, www. Sivim. Info), five years of online vegetation’s data
publishing. *Plant Sociology* 49: 89–95.

</div>

<div id="ref-RN5365" class="csl-entry">

Gómez, J.A.D. 2020. Sintaxonomía de las comunidades vegetales de
cantabria, 2020. *Flora Montiberica* 56–92.

</div>

<div id="ref-RN5381" class="csl-entry">

Herve, M. 2023. RVAideMemoire: Testing and plotting procedures for
biostatistics. R package version 0.9-83-2.
Https://CRAN.r-project.org/package=RVAideMemoire.

</div>

<div id="ref-RN5363" class="csl-entry">

Izco, J., Amigo, J., & García-San León, D. 2000. Análisis y
clasificación de la vegetación de galicia (españa), II. La vegetación
herbácea. *Lazaroa* 21:

</div>

<div id="ref-RN5375" class="csl-entry">

Jiménez-Alfaro González, F. de B., Carlón, L., Fernández Pascual, E.,
Cires Rodríguez, E., Díaz González, T.E., & Nava Fernández, H.S. 2021.
Checklist of the vascular plants of the cantabrian mountains.
*Mediterranean Botany*

</div>

<div id="ref-RN3166" class="csl-entry">

Lê, S., Josse, J., & Husson, F. 2008. FactoMineR: An r package for
multivariate analysis. *Journal of Statistical Software* 25: 1–18.

</div>

<div id="ref-RN5101" class="csl-entry">

Midolo, G., Herben, T., Axmanová, I., Marcenò, C., Pätsch, R.,
Bruelheide, H., Karger, D.N., Aćić, S., Bergamini, A., Bergmeier, E.,
Biurrun, I., Bonari, G., Čarni, A., Chiarucci, A., De Sanctis, M.,
Demina, O., Dengler, J., Dziuba, T., Fanelli, G., Garbolino, E., Giusso
del Galdo, G., Goral, F., Güler, B., Hinojos-Mendoza, G., Jansen, F.,
Jiménez-Alfaro, B., Lengyel, A., Lenoir, J., Pérez-Haase, A., Pielech,
R., Prokhorov, V., Rašomavičius, V., Ruprecht, E., Rūsiņa, S., Šilc, U.,
Škvorc, Ž., Stančić, Z., Tatarenko, I., & Chytrý, M. 2023. [Disturbance
indicator values for european
plants](https://doi.org/10.1111/geb.13603). *Global Ecology and
Biogeography* 32: 24–34.

</div>

<div id="ref-RN5373" class="csl-entry">

Moreno, J.M., Pineda, F.D., & Rivas‐Martinez, S. 1990. Climate and
vegetation at the eurosiberian‐mediterranean boundary in the iberian
peninsula. *Journal of vegetation science* 1: 233–244.

</div>

<div id="ref-RN4698" class="csl-entry">

Mucina, L., Bültmann, H., Dierßen, K., Theurillat, J.-P., Raus, T.,
Čarni, A., Šumberová, K., Willner, W., Dengler, J., García, R.G.,
Chytrý, M., Hájek, M., Di Pietro, R., Iakushenko, D., Pallas, J.,
Daniëls, F.J.A., Bergmeier, E., Santos Guerra, A., Ermakov, N.,
Valachovič, M., Schaminée, J.H.J., Lysenko, T., Didukh, Y.P., Pignatti,
S., Rodwell, J.S., Capelo, J., Weber, H.E., Solomeshch, A., Dimopoulos,
P., Aguiar, C., Hennekens, S.M., & Tichý, L. 2016. [Vegetation of
europe: Hierarchical floristic classification system of vascular plant,
bryophyte, lichen, and algal
communities](https://doi.org/10.1111/avsc.12257). *Applied Vegetation
Science* 19: 3–264.

</div>

<div id="ref-RN5386" class="csl-entry">

Oksanen, J., Simpson, G., Blanchet, F., Kindt, R., Legendre, P.,
Minchin, P., O’Hara, R., Solymos, P., Stevens, M., Szoecs, E., Wagner,
H., Barbour, M., Bedward, M., Bolker, B., Borcard, D., Carvalho, G.,
Chirico, M., De Caceres, M., Durand, S., Evangelista, H., FitzJohn, R.,
Friendly, M., Furneaux, B., Hannigan, G., Hill, M., Lahti, L., McGlinn,
D., Ouellette, M., Cunh, E., Smith, T., Stier, S., Ter Braak, C., &
Weedon, J. 2022. Vegan: Community ecology package. R package version
2.6-4. Https://CRAN.r-project.org/package=vegan.

</div>

<div id="ref-RN4667" class="csl-entry">

Olson, D.M., Dinerstein, E., Wikramanayake, E.D., Burgess, N.D., Powell,
G.V., Underwood, E.C., D’amico, J.A., Itoua, I., Strand, H.E., &
Morrison, J.C. 2001. Terrestrial ecoregions of the world: A new map of
life on earth: A new global map of terrestrial ecoregions provides an
innovative tool for conserving biodiversity. *BioScience* 51: 933–938.

</div>

<div id="ref-RN5376" class="csl-entry">

POWO. 2023. Plants of the world online. Facilitated by the royal botanic
gardens, kew. Published on the internet;
http://www.plantsoftheworldonline.org/ retrieved september 2022.".

</div>

<div id="ref-RN5371" class="csl-entry">

Preislerová, Z., Jiménez-Alfaro, B., Mucina, L., Berg, C., Bonari, G.,
Kuzemko, A., Landucci, F., Marcenò, C., Monteiro-Henriques, T., Novák,
P., Vynokurov, D., Bergmeier, E., Dengler, J., Apostolova, I., Bioret,
F., Biurrun, I., Campos, J.A., Capelo, J., Čarni, A., Çoban, S., Csiky,
J., Ćuk, M., Ćušterevska, R., Daniëls, F.J.A., De Sanctis, M., Didukh,
Y., Dítě, D., Fanelli, G., Golovanov, Y., Golub, V., Guarino, R., Hájek,
M., Iakushenko, D., Indreica, A., Jansen, F., Jašková, A., Jiroušek, M.,
Kalníková, V., Kavgacı, A., Kucherov, I., Küzmič, F., Lebedeva, M.,
Loidi, J., Lososová, Z., Lysenko, T., Milanović, Đ., Onyshchenko, V.,
Perrin, G., Peterka, T., Rašomavičius, V., Rodríguez-Rojo, M.P.,
Rodwell, J.S., Rūsiņa, S., Sánchez-Mata, D., Schaminée, J.H.J.,
Semenishchenkov, Y., Shevchenko, N., Šibík, J., Škvorc, Ž., Smagin, V.,
Stešević, D., Stupar, V., Šumberová, K., Theurillat, J.-P., Tikhonova,
E., Tzonev, R., Valachovič, M., Vassilev, K., Willner, W., Yamalov, S.,
Večeřa, M., & Chytrý, M. 2022. [Distribution maps of vegetation
alliances in europe](https://doi.org/10.1111/avsc.12642). *Applied
Vegetation Science* 25: e12642.

</div>

<div id="ref-RN5387" class="csl-entry">

R Core Team. 2023. [R: A language and environment for statistical
computing. Version 4.3.1](https://www.r-project.org/).

</div>

<div id="ref-RN4697" class="csl-entry">

Rivas-Martínez, S., Fernández-González, F., Loidi, J., Lousã, M., &
Penas, A. 2001. Syntaxonomical checklist of vascular plant communities
of spain and portugal to association level. *Itinera Geobotanica* 14:
5–341.

</div>

<div id="ref-RN4699" class="csl-entry">

Rivas-Martínez, S., Penas, Á., González, T.E.D., Cantó, P., Río, S. del,
Costa, J.C., Herrero, L., & Molero, J. 2017. Biogeographic units of the
iberian peninsula and baelaric islands to district level. A concise
synopsis. In *The vegetation of the iberian peninsula*, pp. 131–188.
Springer.

</div>

<div id="ref-RN2311" class="csl-entry">

Roberts, D.W. 2016. Labdsv: Ordination and multivariate analysis for
ecology. R package version 1.8-0.

</div>

<div id="ref-RN5379" class="csl-entry">

Roleček, J., Tichý, L., Zelený, D., & Chytrý, M. 2009. [Modified
TWINSPAN classification in which the hierarchy respects cluster
heterogeneity](https://doi.org/10.1111/j.1654-1103.2009.01062.x).
*Journal of Vegetation Science* 20: 596–602.

</div>

<div id="ref-RN5378" class="csl-entry">

Uría Arizaga, O. 2020. Ensamblaje de comunidades vegetales en parcelas
urbanas abandonadas de asturias. *Trabajo Fin de Máster, Universidad de
Oviedo*

</div>

<div id="ref-RN4662" class="csl-entry">

Wickham, H., Averick, M., Bryan, J., Chang, W., McGowan, L., François,
R., Grolemund, G., Hayes, A., Henry, L., & Hester, J. 2019. Welcome to
the tidyverse. *Journal of Open Source Software* 4: 1686.

</div>

<div id="ref-RN5382" class="csl-entry">

Wiser, S.K., & De Cáceres, M. 2013. [Updating vegetation
classifications: An example with new zealand’s woody
vegetation](https://doi.org/10.1111/j.1654-1103.2012.01450.x). *Journal
of Vegetation Science* 24: 80–93.

</div>

<div id="ref-RN5377" class="csl-entry">

Zabaleta Mendizábal, I. 1990. Flora y vegetación de la felguera
(langreo) y sus alrededores. *Tesina de Licenciatura, Universidad de
Oviedo.*

</div>

<div id="ref-RN5380" class="csl-entry">

Zelený, D. 2021. twinspanR: TWo-way INdicator SPecies ANalysis (and its
modified version) in r. R package version 0.22.

</div>

</div>

# Figures

<div class="figure">

<img src="../results/figures/maps.png" alt="." width="4228" />
<p class="caption">
.
</p>

</div>

<div class="figure">

<img src="../results/figures/dca.png" alt="." width="4228" />
<p class="caption">
.
</p>

</div>

<div class="figure">

<img src="../results/figures/cwms.png" alt="." width="4228" />
<p class="caption">
.
</p>

</div>

<div class="figure">

<img src="../results/figures/boxplots.png" alt="." width="4228" />
<p class="caption">
.
</p>

</div>
