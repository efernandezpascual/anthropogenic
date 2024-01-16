Anthropogenic plant communities of the Iberian Atlantic ecoregion
================

# Introduction

Anthropogenic vegetation is the set of plant communities that occur as a
direct consequence of human activities, and is chiefly composed by the
weed vegetation of arable fields and the ruderal vegetation of human
settlements and their surroundings ([Lososova & Simonova
2008](#ref-RN5441)). The formation of anthropogenic vegetation in
temperate Europe has been characterized by a constant enrichment
produced by the arrival of alien species: first archaeophytes starting
in the Neolithic and peaking in the Bronze Age; and then neophytes from
the Modern Age to the present day ([Brun 2009](#ref-RN5439)).
Synanthropic archaeophytes include many Mediterranean taxa that started
their expansion into temperate areas during the Mid-Holocene warm
period, but it is difficult to disentangle to what extent this expansion
was favored by human activities and/or ongoing climatic changes
([Cayless & Tipping 2002](#ref-RN5443); [Cordova & Lehmann
2003](#ref-RN5432)), especially in southern European areas close to the
transition between the Mediterranean and the temperate climates
([Celesti‐Grapow et al. 2009](#ref-RN5444)). Meanwhile, synanthropic
neophytes include many American, African and Asian taxa that arrived as
a consequence of the global trade networks established by the Western
European colonial powers ([Lenzner et al. 2022](#ref-RN5451)). In the
last century, anthropogenic vegetation has shown a decrease in species
richness and diversity ([Pysek et al. 2004](#ref-RN5423)), as rare
synanthropic species have become rarer, and neophytes have increased
their abundance at the expense of natives and archaeophytes ([Lososova &
Simonova 2008](#ref-RN5441)).

The anthropogenic communities of human-made habitats make up an
important part of the supply of natural elements in urban and peri-urban
habitats ([Kowarik 2018](#ref-RN5445)). In densely-populated city
landscapes, the plant communities that colonize urban vacant lots
([Johnson et al. 2017](#ref-RN2300)) are a useful biodiversity resource
with high ecological and societal potential ([Anderson & Minor
2017](#ref-RN5446)). Anthropogenic vegetation cover can also impact
regional-level extreme climatic events ([Stefanon et al.
2014](#ref-RN5440)). Furthermore, many synanthropic plants can
accumulate heavy metals in their biomass ([Kostryukova et al.
2017](#ref-RN5433)), making them valuable candidates for nature-based
solutions such as bioremediation and restoration of degraded landscapes
([Song et al. 2019](#ref-RN5447)).

The Iberian Atlantic ecoregion has had a long history of human
habitation dating back to the Cantabrian Upper Paleolithic ([Straus
2005](#ref-RN5450)). This, together with its transitional position at
the border between the temperate and Mediterranean climatic zones of
Europe ([Loidi 2017](#ref-RN4700)), suggests a long regional history for
archaeophyte-rich anthropogenic plant communities, and supports a
current high diversity of anthropogenic plant communities combining
temperate and Mediterranean floristic elements ([Díaz González
2020](#ref-RN5008)). Historical trade links with America and Asia,
together with the warm temperate climate, have made the region a hotspot
for plant invasions by neophytes ([**Checklist?**](#ref-Checklist)).
Recent processes of postindustrial land-use change have left large areas
of brownfields whose management and restoration requires an
understanding of anthropogenic communities able to colonize or restore
them ([Gallego et al. 2016](#ref-RN5448); [Matanzas et al.
2021](#ref-RN5449)). Although there is a long tradition of studying weed
and ruderal communities in the ecoregion ([Aedo et al.
1988](#ref-RN5364); [González et al. 1988](#ref-RN5360); [Merino,
González, González, et al. 1988](#ref-RN5359); [Merino, González,
Morales, et al. 1988](#ref-RN5361)) there is a current need for a
regional-level synthesis that revises the classification and updates it
in accord with recent developments in European vegetation science
([Mucina et al. 2016](#ref-RN4698)) and habitat classification ([Chytrý
et al. 2020](#ref-RN5061)). In this article we have performed such a
synthesis with two main objectives: (1) provide an updated
classification of anthropogenic plant communities in the Iberian
Atlantic ecoregion, and (2) describe the main patterns of variation in
terms of species traits and ecological and disturbance preferences.

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
4 EUNIS habitat code, using pre-existing codes when they existed, and
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
groups with no ecological significance, and thus we kept the 28
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
species were *Ochlopoa annua* (621 occurrences), *Urtica dioica* (592),
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
(35% variance explained) were disturbance frequency, soil disturbance,
mowing frequency and light requirements; it separated communities
thriving with frequent disturbances in open situations (classes
*Polygono-Poetea annuae*, *Sisymbrietea*, *Digitario-Eragrostietea* and
*Papaveretea rhoeadis*) from communities preferring less frequent
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

***Cymbalario-Parietarietea diffusae*** Vegetation of human-made walls.

1.  *Galio valantiae-Parietarion judaicae* Vegetation of dry walls.
    Occupies warmer, drier and more nutrient-rich situations than the
    other alliance in the class, has a shorter flowering season and is
    more adapted to disturbances (**Fig. 4**). Wide distribution in the
    ecoregion (**Fig. 1**). Diagnostic species (**Supplementary 5**):
    *Parietaria judaica* aggr., *Centranthus ruber*, *Asplenium
    trichomanes*.

2.  *Cymbalario-Asplenion* Vegetation of mesic walls. Occupies colder,
    wetter and less nutrient-rich situations than the other alliance in
    the class, has a longer flowering season and is less adapted to
    disturbances (**Fig. 4**). Wide distribution in the ecoregion
    (**Fig. 1**). Diagnostic species (**Supplementary 5**): *Cymbalaria
    muralis*.

***Polygono-Poetea annuae*** Dwarf vegetation of heavily-trampled sites.

3.  *Polycarpion tetraphylli* Dwarf-annual trampled vegetation of warm
    and sunny sites. Occupies warmer, sunnier and less nutrient-rich
    situations than the other alliances in the class and has an earlier
    flowering season (**Fig. 4**). Wide distribution in the ecoregion,
    specially along the coast and in the more Mediterranean valleys of
    the interior (**Fig. 1**). Diagnostic species (**Supplementary 5**):
    *Sagina apetala*, *Plantago coronopus*, *Crassula tillaea*,
    *Spergularia marina*.

4.  *Polygono-Coronopodion* Dwarf-annual trampled vegetation of dry
    sites. Occupies colder, drier and more nutrient-rich situations than
    the other alliances in the class, and has a higher proportion of
    neophytes (**Fig. 4**). Wide distribution in the ecoregion (**Fig.
    1**). Diagnostic species (**Supplementary 5**): *Matricaria
    suaveolens*, *Polygonum aviculare*.

5.  *Saginion procumbentis* Dwarf trampled vegetation of mesic sites.
    Occupies colder, wetter and more nutrient-rich situations than the
    other alliance in the class, and is less dominated by therophytes
    (**Fig. 4**). Distribution concentrated in the central part of the
    ecoregion (**Fig. 1**). Diagnostic species (**Supplementary 5**):
    *Sagina procumbens*, *Bryum argenteum*.

***Papaveretea rhoeadis*** Annual weed vegetation of crops and gardens.

6.  *Caucalidion lappulae* Annual weed vegetation of cereal crops on
    base-rich soils. Adapted to more frequent and severe disturbances
    than the other alliances in the class (**Fig. 4**). Distribution
    mostly limited to the more Mediterranean valleys south of the
    Cantabrian Mountains (**Fig. 1**). Diagnostic species
    (**Supplementary 5**): *Cyanus segetum*, *Papaver rhoeas*,
    *Trifolium arvense*, *Anacyclus clavatus*, *Valerianella eriocarpa*.

7.  *Scleranthion annui* Annual weed vegetation of cereal crops on
    base-poor soils. Occupies more acidic soils than the other alliances
    in the class, and flowers earlier (**Fig. 4**). Wide distribution in
    the ecoregion, but specially in the west, where acidic bedrocks
    dominate (**Fig. 1**). Diagnostic species (**Supplementary 5**):
    *Mibora minima*, *Rumex acetosella*.

8.  *Oxalidion europeae* Annual weed vegetation of gardens and root
    crops. Occupies wetter, shadier and more nutrient-rich situations
    than the other alliances in the class, has a longer flowering season
    and a higher proportion of neophytes (**Fig. 4**). Wide distribution
    in the ecoregion (**Fig. 1**). Diagnostic species (**Supplementary
    5**): *Stellaria media*, *Veronica persica*.

***Digitario sanguinalis-Eragrostietea minoris*** Summer-annual C4 weed
vegetation.

9.  *Spergulo arvensis-Erodion cicutariae* Summer-annual C4 weed
    vegetation. Late-flowering alliance rich in neophytes and grasses,
    occurring in highly-disturbed and nutrient-rich soils (**Fig. 4**).
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
    season (**Fig. 4**). Sparse occurrence throughout the ecoregion
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
    (**Fig. 4**). Isolated occurrence in the south of the ecoregion
    (**Fig. 1**). Diagnostic species (**Supplementary 5**): *Poa
    compressa*, *Elytrigia repens*, *Potentilla reptans*, *Valerianella
    locusta*.

17. *Carduo carpetani-Cirsion odontolepidis* Thistle ruderal vegetation
    of warm sites. Occupies warmer situations than the other thistle
    alliance in the class (**Fig. 4**). Mostly distributed in the
    Cantabrian Mountains (**Fig. 1**). Diagnostic species
    (**Supplementary 5**): *Onopordum acanthium*.

18. *Cirsion richterano-chodati* Thistle ruderal vegetation of cold
    sites. Occupies colder situations than the other thistle alliance in
    the class (**Fig. 4**). Mostly distributed in the Cantabrian
    Mountains (**Fig. 1**). Diagnostic species (**Supplementary 5**):
    *Cirsium eriophorum*, *Carduus carpetanus*, *Carduus nutans* aggr.

19. *Dauco-Melilotion* Biennial ruderal vegetation. Occupies wetter
    situations than the two thistle alliances in the class, and has a
    higher proportion of therophytes (**Fig. 4**). Sparse occurrence
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
    Sparse occurrence throughout the ecoregion (**Fig. 1**). Diagnostic
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
    river banks and ditches. Occupies warmer and wetter situations than
    the other alliances in the class, flowers later, has taller plants
    and is highly dominated by neophytes and geophytes (**Fig. 4**).
    Isolated occurrence in the western coast of the ecoregion (**Fig.
    1**). Diagnostic species (**Supplementary 5**): *Arundo donax*,
    *Silene latifolia*.

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

# Discussion

The major driver of variation in trampled community composition is soil
moisture ([Golovanov et al. 2023](#ref-RN5434)).

In medieval Switzerland, summer and winter weeds communities could not
be distinguished ([Karg 1995](#ref-RN5431)).

The class *Digitario sanguinalis-Eragrostietea minoris* includes
thermophilic vegetation dominated by C4 plants that occupies arable land
as well as trampled and ruderal sites ([Nemec et al.
2011](#ref-RN5426)).

Anthropogenic vegetation composition is sensitive to micro-scale
management decisions, such as the ownership of domestic dogs ([Pal et
al. 2013](#ref-RN5438)).

Neophytes were more represented in early successional anthropogenic
communities ([Pysek et al. 2004](#ref-RN5423)).

Arable land plants were mainly therophytes and alien species; while
ruderal habitats were richer in perennials and C strategists ([Silc
2010](#ref-RN5436)).

Compare proportion of neophytes to other areas ([Silc et al.
2012](#ref-RN5429); @ [Simonova & Lososova 2008](#ref-RN5435))

Neophytes have no special preferences for local habitat conditions and
their highest proportion was found mainly in disturbed habitats at low
elevations. ([Simonova & Lososova 2008](#ref-RN5435))

Therophytes and hemicryptophytes were most abundant in the life form
spectra ([Tabasevic et al. 2021](#ref-RN5428))

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

<div id="ref-RN5364" class="csl-entry">

Aedo, C., Herrera, M., Prieto, J.F., & Díaz, T. 1988.
<span class="nocase">Datos sobre la vegetación arvense de la Cornisa
Cantábrica</span>. *Lazaroa* 9: 241–254.

</div>

<div id="ref-RN5446" class="csl-entry">

Anderson, E.C., & Minor, E.S. 2017. [<span class="nocase">Vacant lots:
An underexplored resource for ecological and social benefits in
cities</span>](https://doi.org/10.1016/j.ufug.2016.11.015). *Urban
Forestry & Urban Greening* 21: 146–152.

</div>

<div id="ref-RN5439" class="csl-entry">

Brun, C. 2009. [<span class="nocase">Biodiversity changes in highly
anthropogenic environments (cultivated and ruderal) since the Neolithic
in eastern France</span>](https://doi.org/10.1177/0959683609336559).
*Holocene* 19: 861–871.

</div>

<div id="ref-RN3243" class="csl-entry">

Castroviejo, S. 1987. *<span class="nocase">Flora iberica</span>*. Real
Jardín Botánico, CSIC, Madrid.

</div>

<div id="ref-RN5443" class="csl-entry">

Cayless, S.M., & Tipping, R.M. 2002. [<span class="nocase">Data on
mid-Holocene climatic, vegetation and anthropogenic interactions at
Stanshiel Rig, southern
Scotland</span>](https://doi.org/10.1007/s003340200023). *Vegetation
History and Archaeobotany* 11: 201–210.

</div>

<div id="ref-RN5444" class="csl-entry">

Celesti‐Grapow, L., Alessandrini, A., Arrigoni, P.V., Banfi, E.,
Bernardo, L., Bovio, M., Brundu, G., Cagiotti, M.R., Camarda, I., Carli,
E., Conti, F., Fascetti, S., Galasso, G., Gubellini, L., La Valva, V.,
Lucchese, F., Marchiori, S., Mazzola, P., Peccenini, S., Poldini, L.,
Pretto, F., Prosser, F., Siniscalco, C., Villani, M.C., Viegi, L.,
Wilhalm, T., & Blasi, C. 2009. [<span class="nocase">Inventory of the
non‐native flora of
Italy</span>](https://doi.org/10.1080/11263500902722824). *Plant
Biosystems - An International Journal Dealing with all Aspects of Plant
Biology* 143: 386–430.

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
2020. [<span class="nocase">EUNIS Habitat Classification: Expert system,
characteristic species combinations and distribution maps of European
habitats</span>](https://doi.org/10.1111/avsc.12519). *Applied
Vegetation Science* 23: 648–675.

</div>

<div id="ref-RN5432" class="csl-entry">

Cordova, C.E., & Lehmann, P.H. 2003.
[<span class="nocase">Archaeopalynology of synanthropic vegetation in
the \<i\>chora\</i\> of Chersonesos, Crimea,
Ukraine</span>](https://doi.org/10.1016/s0305-4403(03)00044-x). *Journal
of Archaeological Science* 30: 1483–1501.

</div>

<div id="ref-RN5383" class="csl-entry">

De Cáceres, M., Font, X., & Oliva, F. 2010. [<span class="nocase">The
management of vegetation classifications with fuzzy
clustering</span>](https://doi.org/10.1111/j.1654-1103.2010.01211.x).
*Journal of Vegetation Science* 21: 1138–1151.

</div>

<div id="ref-RN5384" class="csl-entry">

Dengler, J., Jansen, F., Chusova, O., Hüllbusch, E., Nobis, M.P., Van
Meerbeek, K., Axmanová, I., Bruun, H.H., Chytrý, M., Guarino, R.,
Karrer, G., Moeys, K., Raus, T., Steinbauer, M.J., Tichý, L., Tyler, T.,
Batsatsashvili, K., Bita-Nicolae, C., Didukh, Y., Diekmann, M.,
Englisch, T., Fernández-Pascual, E., Frank, D., Graf, U., Hájek, M.,
Jelaska, S.D., Jiménez-Alfaro, B., Julve, P., Nakhutsrishvili, G.,
Ozinga, W.A., Ruprecht, E.-K., Šilc, U., Theurillat, J.-P., & Gillet, F.
2023. [<span class="nocase">﻿Ecological Indicator Values for Europe
(EIVE) 1.0</span>](https://doi.org/10.3897/vcs.98324). *Vegetation
Classification and Survey* 4:

</div>

<div id="ref-RN5008" class="csl-entry">

Díaz González, T.E. 2020. <span class="nocase">La vegetación del
Principado de Asturias (España) (esquema sintaxonómico de las
comunidades vegetales)</span>. *Boletín de Ciencias de la Naturaleza del
RIDEA* 55: 339–646.

</div>

<div id="ref-RN5372" class="csl-entry">

Fernández Prieto, J.A., Amigo, J., Bueno, Á., Herrera, M.,
Rodríguez-Guitián, M.A., & Loidi, J. 2020. <span class="nocase">Notas
sobre el Catálogo de comunidades de plantas vasculares de los
territorios iberoatlánticos (I)</span>. *Naturalia Cantabricae* 17–37.

</div>

<div id="ref-RN5385" class="csl-entry">

FloraVeg.EU. 2023. <span class="nocase">FloraVeg.EU – Database of
European Vegetation, Habitats and Flora. www.floraveg.eu. Accessed
December 2023.</span>

</div>

<div id="ref-RN5374" class="csl-entry">

Font, X., Pérez-García, N., Biurrun, I., Fernández-González, F., &
Lence, C. 2012. <span class="nocase">The Iberian and Macaronesian
Vegetation Information System (SIVIM, www. sivim. info), five years of
online vegetation’s data publishing</span>. *Plant Sociology* 49: 89–95.

</div>

<div id="ref-RN5448" class="csl-entry">

Gallego, J.R., Rodríguez-Valdés, E., Esquinas, N., Fernández-Braña, A.,
& Afif, E. 2016. [<span class="nocase">Insights into a 20-ha
multi-contaminated brownfield megasite: An environmental forensics
approach</span>](https://doi.org/10.1016/j.scitotenv.2015.09.153).
*Science of The Total Environment* 563-564: 683–692.

</div>

<div id="ref-RN5434" class="csl-entry">

Golovanov, Y.M., Abramova, L.M., Arepieva, L.A., Devyatova, E.A., &
Ovcharova, N.V. 2023. [<span class="nocase">Review of plant communities
of the class \<i\>Polygono arenastri- Poetea annuae\</i\> in the Russian
Federation</span>](https://doi.org/10.14258/turczaninowia.26.2.13).
*Turczaninowia* 26: 147–169.

</div>

<div id="ref-RN5365" class="csl-entry">

Gómez, J.A.D. 2020. <span class="nocase">Sintaxonomía de las comunidades
vegetales de Cantabria, 2020</span>. *Flora Montiberica* 56–92.

</div>

<div id="ref-RN5360" class="csl-entry">

González, T.E.D., Merino, Á.P., Cembranos, L.H., Morales, C.P., García,
F.L., & Alfonso, A.T. 1988. <span class="nocase">Estudio de los
herbazales nitrófilos vivaces y comunidades ruderal viarios de la
provincia de León (NW de España). Study of vivacious nitrophilous
grasslands and roadside communities of León province (NW of
Spain)</span>. *Acta Botanica Barcinonensia*

</div>

<div id="ref-RN5381" class="csl-entry">

Herve, M. 2023. <span class="nocase">RVAideMemoire: Testing and Plotting
Procedures for Biostatistics. R package version 0.9-83-2.
https://CRAN.R-project.org/package=RVAideMemoire</span>.

</div>

<div id="ref-RN5363" class="csl-entry">

Izco, J., Amigo, J., & García-San León, D. 2000.
<span class="nocase">Análisis y clasificación de la vegetación de
Galicia (España), II. La vegetación herbácea</span>. *Lazaroa* 21:

</div>

<div id="ref-RN5375" class="csl-entry">

Jiménez-Alfaro González, F. de B., Carlón, L., Fernández Pascual, E.,
Cires Rodríguez, E., Díaz González, T.E., & Nava Fernández, H.S. 2021.
<span class="nocase">Checklist of the vascular plants of the Cantabrian
Mountains</span>. *Mediterranean Botany*

</div>

<div id="ref-RN2300" class="csl-entry">

Johnson, A.L., Borowy, D., & Swan, C.M. 2017. <span class="nocase">Land
use history and seed dispersal drive divergent plant community assembly
patterns in urban vacant lots</span>. *Journal of Applied Ecology*. doi:
[10.1111/1365-2664.12958](https://doi.org/10.1111/1365-2664.12958)

</div>

<div id="ref-RN5431" class="csl-entry">

Karg, S. 1995. [PLANT DIVERSITY IN LATE-MEDIEVAL CORNFIELDS OF NORTHERN
SWITZERLAND](<Go to ISI>://WOS:A1995TE00600004). *Vegetation History and
Archaeobotany* 4: 41–50.

</div>

<div id="ref-RN5433" class="csl-entry">

Kostryukova, A.M., Mashkova, I.V., Krupnova, T.G., & Shchelkanova, E.E.
2017. [STUDY OF SYNANTHROPIC PLANTS OF THE SOUTH
URAL](https://doi.org/10.21660/2017.40.3519). *International Journal of
Geomate* 13: 60–65.

</div>

<div id="ref-RN5445" class="csl-entry">

Kowarik, I. 2018. [<span class="nocase">Urban wilderness: Supply,
demand, and access</span>](https://doi.org/10.1016/j.ufug.2017.05.017).
*Urban Forestry & Urban Greening* 29: 336–347.

</div>

<div id="ref-RN3166" class="csl-entry">

Lê, S., Josse, J., & Husson, F. 2008. <span class="nocase">FactoMineR:
an R package for multivariate analysis</span>. *Journal of Statistical
Software* 25: 1–18.

</div>

<div id="ref-RN5451" class="csl-entry">

Lenzner, B., Latombe, G., Schertler, A., Seebens, H., Yang, Q., Winter,
M., Weigelt, P., Kleunen, M. van, Pyšek, P., Pergl, J., Kreft, H.,
Dawson, W., Dullinger, S., & Essl, F. 2022.
[<span class="nocase">Naturalized alien floras still carry the legacy of
European
colonialism</span>](https://doi.org/10.1038/s41559-022-01865-1). *Nature
Ecology & Evolution* 6: 1723–1732.

</div>

<div id="ref-RN4700" class="csl-entry">

Loidi, J. 2017. *<span class="nocase">The Vegetation of the Iberian
Peninsula</span>*. Springer.

</div>

<div id="ref-RN5441" class="csl-entry">

Lososova, Z., & Simonova, D. 2008. [<span class="nocase">Changes during
the 20th century in species composition of synanthropic vegetation in
Moravia (Czech Republic)</span>](<Go to ISI>://WOS:000259902900004).
*Preslia* 80: 291–305.

</div>

<div id="ref-RN5449" class="csl-entry">

Matanzas, N., Afif, E., Díaz, T.E., & Gallego, J.R. 2021.
[<span class="nocase">Phytoremediation Potential of Native Herbaceous
Plant Species Growing on a Paradigmatic Brownfield
Site</span>](https://doi.org/10.1007/s11270-021-05234-9). *Water, Air, &
Soil Pollution* 232: 290.

</div>

<div id="ref-RN5359" class="csl-entry">

Merino, A.P., González, T.E.D., González, M.E.G., Pacheco, M.J.L., &
Puente, E. 1988. <span class="nocase">Datos sobre los cardales y tobales
(Onopordetea acanth¡ i) en la provincia de León</span>. *Lazaroa* 10:
987–88.

</div>

<div id="ref-RN5361" class="csl-entry">

Merino, Á.P., González, T.E.D., Morales, C.P., García, E.P., González,
M.E.G., & Alfonso, A.T. 1988. <span class="nocase">Aportaciones al
conocimiento de las comunidades de malas hierbas de cultivo en la
provincia de León</span>. *Acta Botanica Barcinonensia*

</div>

<div id="ref-RN5101" class="csl-entry">

Midolo, G., Herben, T., Axmanová, I., Marcenò, C., Pätsch, R.,
Bruelheide, H., Karger, D.N., Aćić, S., Bergamini, A., Bergmeier, E.,
Biurrun, I., Bonari, G., Čarni, A., Chiarucci, A., De Sanctis, M.,
Demina, O., Dengler, J., Dziuba, T., Fanelli, G., Garbolino, E., Giusso
del Galdo, G., Goral, F., Güler, B., Hinojos-Mendoza, G., Jansen, F.,
Jiménez-Alfaro, B., Lengyel, A., Lenoir, J., Pérez-Haase, A., Pielech,
R., Prokhorov, V., Rašomavičius, V., Ruprecht, E., Rūsiņa, S., Šilc, U.,
Škvorc, Ž., Stančić, Z., Tatarenko, I., & Chytrý, M. 2023.
[<span class="nocase">Disturbance indicator values for European
plants</span>](https://doi.org/10.1111/geb.13603). *Global Ecology and
Biogeography* 32: 24–34.

</div>

<div id="ref-RN5373" class="csl-entry">

Moreno, J.M., Pineda, F.D., & Rivas‐Martinez, S. 1990.
<span class="nocase">Climate and vegetation at the
Eurosiberian‐Mediterranean boundary in the Iberian Peninsula</span>.
*Journal of vegetation science* 1: 233–244.

</div>

<div id="ref-RN4698" class="csl-entry">

Mucina, L., Bültmann, H., Dierßen, K., Theurillat, J.-P., Raus, T.,
Čarni, A., Šumberová, K., Willner, W., Dengler, J., García, R.G.,
Chytrý, M., Hájek, M., Di Pietro, R., Iakushenko, D., Pallas, J.,
Daniëls, F.J.A., Bergmeier, E., Santos Guerra, A., Ermakov, N.,
Valachovič, M., Schaminée, J.H.J., Lysenko, T., Didukh, Y.P., Pignatti,
S., Rodwell, J.S., Capelo, J., Weber, H.E., Solomeshch, A., Dimopoulos,
P., Aguiar, C., Hennekens, S.M., & Tichý, L. 2016.
[<span class="nocase">Vegetation of Europe: hierarchical floristic
classification system of vascular plant, bryophyte, lichen, and algal
communities</span>](https://doi.org/10.1111/avsc.12257). *Applied
Vegetation Science* 19: 3–264.

</div>

<div id="ref-RN5426" class="csl-entry">

Nemec, R., Lososova, Z., Drevojan, P., & Zakova, K. 2011.
[<span class="nocase">Synanthropic vegetation of the \<i\>Eragrostion
cilianensi\</i\>-\<i\>minoris\</i\> alliance in the Czech
Republic</span>](https://doi.org/10.2478/s11756-011-0108-0). *Biologia*
66: 1019–1026.

</div>

<div id="ref-RN5386" class="csl-entry">

Oksanen, J., Simpson, G., Blanchet, F., Kindt, R., Legendre, P.,
Minchin, P., O’Hara, R., Solymos, P., Stevens, M., Szoecs, E., Wagner,
H., Barbour, M., Bedward, M., Bolker, B., Borcard, D., Carvalho, G.,
Chirico, M., De Caceres, M., Durand, S., Evangelista, H., FitzJohn, R.,
Friendly, M., Furneaux, B., Hannigan, G., Hill, M., Lahti, L., McGlinn,
D., Ouellette, M., Cunh, E., Smith, T., Stier, S., Ter Braak, C., &
Weedon, J. 2022. <span class="nocase">vegan: Community Ecology Package.
R package version 2.6-4.
https://CRAN.R-project.org/package=vegan</span>.

</div>

<div id="ref-RN4667" class="csl-entry">

Olson, D.M., Dinerstein, E., Wikramanayake, E.D., Burgess, N.D., Powell,
G.V., Underwood, E.C., D’amico, J.A., Itoua, I., Strand, H.E., &
Morrison, J.C. 2001. <span class="nocase">Terrestrial ecoregions of the
world: a new map of life on earth: a new global map of terrestrial
ecoregions provides an innovative tool for conserving
biodiversity</span>. *BioScience* 51: 933–938.

</div>

<div id="ref-RN5438" class="csl-entry">

Pal, R.W., Csete, S., Botta-Dukat, Z., & Pinke, G. 2013.
[<span class="nocase">Composition and Diversity of Lawn Flora in
Differently Managed Village Yards - A Case Study from Southwestern
Hungary</span>](https://doi.org/10.1007/s12224-012-9142-0). *Folia
Geobotanica* 48: 209–227.

</div>

<div id="ref-RN5376" class="csl-entry">

POWO. 2023. <span class="nocase">Plants of the World Online. Facilitated
by the Royal Botanic Gardens, Kew. Published on the Internet;
http://www.plantsoftheworldonline.org/ Retrieved September
2022."</span>.

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
Večeřa, M., & Chytrý, M. 2022. [<span class="nocase">Distribution maps
of vegetation alliances in
Europe</span>](https://doi.org/10.1111/avsc.12642). *Applied Vegetation
Science* 25: e12642.

</div>

<div id="ref-RN5423" class="csl-entry">

Pysek, P., Chocholousková, Z., Pysek, A., Jarosík, V., Chytry, M., &
Tichy, L. 2004. [<span class="nocase">Trends in species diversity and
composition of urban vegetation over three
decades</span>](https://doi.org/10.1111/j.1654-1103.2004.tb02321.x).
*Journal of Vegetation Science* 15: 781–788.

</div>

<div id="ref-RN5387" class="csl-entry">

R Core Team. 2023. [<span class="nocase">R: a language and environment
for statistical computing. Version
4.3.1</span>](https://www.r-project.org/).

</div>

<div id="ref-RN4697" class="csl-entry">

Rivas-Martínez, S., Fernández-González, F., Loidi, J., Lousã, M., &
Penas, A. 2001. <span class="nocase">Syntaxonomical checklist of
vascular plant communities of Spain and Portugal to association
level</span>. *Itinera Geobotanica* 14: 5–341.

</div>

<div id="ref-RN4699" class="csl-entry">

Rivas-Martínez, S., Penas, Á., González, T.E.D., Cantó, P., Río, S. del,
Costa, J.C., Herrero, L., & Molero, J. 2017.
<span class="nocase">Biogeographic units of the Iberian Peninsula and
Baelaric Islands to district level. A concise synopsis</span>. In
*<span class="nocase">The Vegetation of the Iberian Peninsula</span>*,
pp. 131–188. Springer.

</div>

<div id="ref-RN2311" class="csl-entry">

Roberts, D.W. 2016. <span class="nocase">labdsv: Ordination and
Multivariate Analysis for Ecology. R package version 1.8-0</span>.

</div>

<div id="ref-RN5379" class="csl-entry">

Roleček, J., Tichý, L., Zelený, D., & Chytrý, M. 2009.
[<span class="nocase">Modified TWINSPAN classification in which the
hierarchy respects cluster
heterogeneity</span>](https://doi.org/10.1111/j.1654-1103.2009.01062.x).
*Journal of Vegetation Science* 20: 596–602.

</div>

<div id="ref-RN5436" class="csl-entry">

Silc, U. 2010. [<span class="nocase">Synanthropic vegetation: pattern of
various disturbances on life history
traits</span>](<Go to ISI>://WOS:000290511700006). *Acta Botanica
Croatica* 69: 215–227.

</div>

<div id="ref-RN5429" class="csl-entry">

Silc, U., Vrbnicanin, S., Bozic, D., Carni, A., & Stevanovic, Z.D. 2012.
[<span class="nocase">Alien plant species and factors of invasiveness of
anthropogenic vegetation in the Northwestern Balkans - a
phytosociological
approach</span>](https://doi.org/10.2478/s11535-012-0049-9). *Central
European Journal of Biology* 7: 720–730.

</div>

<div id="ref-RN5435" class="csl-entry">

Simonova, D., & Lososova, Z. 2008. [<span class="nocase">Which factors
determine plant invasions in man-made habitats in the Czech
Republic?</span>](https://doi.org/10.1016/j.ppees.2007.11.003)
*Perspectives in Plant Ecology Evolution and Systematics* 10: 89–100.

</div>

<div id="ref-RN5447" class="csl-entry">

Song, Y., Kirkwood, N., Maksimović, Č., Zheng, X., O’Connor, D., Jin,
Y., & Hou, D. 2019. [<span class="nocase">Nature based solutions for
contaminated land remediation and brownfield redevelopment in cities: A
review</span>](https://doi.org/10.1016/j.scitotenv.2019.01.347).
*Science of The Total Environment* 663: 568–579.

</div>

<div id="ref-RN5440" class="csl-entry">

Stefanon, M., Schindler, S., Drobinski, P., Noblet-Ducoudre, N. de, &
D’Andrea, F. 2014. [<span class="nocase">Simulating the effect of
anthropogenic vegetation land cover on heatwave temperatures over
central France</span>](https://doi.org/10.3354/cr01230). *Climate
Research* 60: 133–146.

</div>

<div id="ref-RN5450" class="csl-entry">

Straus, L.G. 2005. [<span class="nocase">The Upper Paleolithic of
Cantabrian Spain</span>](https://doi.org/10.1002/evan.20067).
*Evolutionary Anthropology: Issues, News, and Reviews* 14: 145–158.

</div>

<div id="ref-RN5428" class="csl-entry">

Tabasevic, M., Lakusic, D., Kuzmanovic, N., Vukojicic, S., Glisic, M., &
Jovanovic, S. 2021. [<span class="nocase">Ruderal vegetation in
Serbia-diversity and floristic
composition</span>](https://doi.org/10.2298/botserb2102251t). *Botanica
Serbica* 45: 251–261.

</div>

<div id="ref-RN5378" class="csl-entry">

Uría Arizaga, O. 2020. <span class="nocase">Ensamblaje de comunidades
vegetales en parcelas urbanas abandonadas de asturias</span>. *Trabajo
Fin de Máster, Universidad de Oviedo*

</div>

<div id="ref-RN4662" class="csl-entry">

Wickham, H., Averick, M., Bryan, J., Chang, W., McGowan, L., François,
R., Grolemund, G., Hayes, A., Henry, L., & Hester, J. 2019.
<span class="nocase">Welcome to the Tidyverse</span>. *Journal of Open
Source Software* 4: 1686.

</div>

<div id="ref-RN5382" class="csl-entry">

Wiser, S.K., & De Cáceres, M. 2013. [<span class="nocase">Updating
vegetation classifications: an example with New Zealand’s woody
vegetation</span>](https://doi.org/10.1111/j.1654-1103.2012.01450.x).
*Journal of Vegetation Science* 24: 80–93.

</div>

<div id="ref-RN5377" class="csl-entry">

Zabaleta Mendizábal, I. 1990. <span class="nocase">Flora y vegetación de
La Felguera (Langreo) y sus alrededores. </span>. *Tesina de
Licenciatura, Universidad de Oviedo.*

</div>

<div id="ref-RN5380" class="csl-entry">

Zelený, D. 2021. <span class="nocase">twinspanR: TWo-way INdicator
SPecies ANalysis (and its modified version) in R. R package version
0.22.</span>

</div>

</div>

# Figures

<div class="figure">

<img src="../results/figures/maps.png" alt="Figure 1. Distribution of the anthropogenic alliances in the Iberian Atlantic ecoregion. Each dot represents a relevé. Dots are colored by vegetation classes." width="4228" />
<p class="caption">
Figure 1. Distribution of the anthropogenic alliances in the Iberian
Atlantic ecoregion. Each dot represents a relevé. Dots are colored by
vegetation classes.
</p>

</div>

<div class="figure">

<img src="../results/figures/dca.png" alt="Figure 2. Ordination of the floristic composition of the anthropogenic plant communities of the Iberian Atlantic ecoregion. The ordination is the results of a Detrended Correspondence Analysis grouped by vegetation classes (A, left) and alliances (B, right)." width="4228" />
<p class="caption">
Figure 2. Ordination of the floristic composition of the anthropogenic
plant communities of the Iberian Atlantic ecoregion. The ordination is
the results of a Detrended Correspondence Analysis grouped by vegetation
classes (A, left) and alliances (B, right).
</p>

</div>

<div class="figure">

<img src="../results/figures/cwms.png" alt="Figure 3. Ordination of the community-level species traits and ecological preferences. The ordinations are the results of a Principal Component Analysis calculated for the community-weighted means for species traits (A, left) and ecological and disturbance indicator values (B, right)." width="4228" />
<p class="caption">
Figure 3. Ordination of the community-level species traits and
ecological preferences. The ordinations are the results of a Principal
Component Analysis calculated for the community-weighted means for
species traits (A, left) and ecological and disturbance indicator values
(B, right).
</p>

</div>

<div class="figure">

<img src="../results/figures/boxplots.png" alt="Figure 4. Community-level species traits and ecological preferences by alliance. Boxplots calculated for the community-weighted means for species traits and ecological and disturbance indicator values." width="4228" />
<p class="caption">
Figure 4. Community-level species traits and ecological preferences by
alliance. Boxplots calculated for the community-weighted means for
species traits and ecological and disturbance indicator values.
</p>

</div>
