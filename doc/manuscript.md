Anthropogenic plant communities of the Iberian Atlantic ecoregion
================

# Introduction

Anthropogenic vegetation is the set of plant communities that occur as a
direct consequence of human activities, and is chiefly composed by the
weed vegetation of arable fields and the ruderal vegetation of human
settlements and their surroundings ([Lososova & Simonova
2008](#ref-RN5441)). The anthropogenic communities of human-made
habitats make up an important part of the supply of natural elements in
urban and peri-urban habitats ([Kowarik 2018](#ref-RN5445)). In
densely-populated city landscapes, the plant communities that colonize
urban vacant lots ([Johnson et al. 2017](#ref-RN2300)) are a useful
biodiversity resource with high ecological and societal potential
([Anderson & Minor 2017](#ref-RN5446)). Anthropogenic vegetation cover
can also impact regional-level extreme climatic events ([Stefanon et al.
2014](#ref-RN5440)). Furthermore, many synanthropic plants can
accumulate heavy metals in their biomass ([Kostryukova et al.
2017](#ref-RN5433)), making them valuable candidates for nature-based
solutions such as bioremediation and restoration of degraded landscapes
([Song et al. 2019](#ref-RN5447)).

The anthropogenic vegetation of temperate Europe is formed by an
original pool of native species favored by humans, but this pool has
been constantly enriched by the arrival of alien species: first
archaeophytes starting in the Neolithic and peaking in the Bronze Age;
and then neophytes from the Modern Age (after 1.500 A.D.) to the present
day ([Brun 2009](#ref-RN5439)). Synanthropic archaeophytes include many
Mediterranean taxa that started their expansion into temperate areas
during the Mid-Holocene warm period, but it is difficult to disentangle
to what extent this expansion was favored by human activities and/or
ongoing climatic changes ([Cayless & Tipping 2002](#ref-RN5443);
[Cordova & Lehmann 2003](#ref-RN5432)), especially in southern European
areas close to the transition between the Mediterranean and the
temperate climates ([Celesti‐Grapow et al. 2009](#ref-RN5444)).
Meanwhile, synanthropic neophytes include many American, African and
Asian taxa that arrived as a consequence of the global trade networks
established by the Western European colonial powers ([Lenzner et al.
2022](#ref-RN5451)). In the last century, anthropogenic vegetation has
shown a decrease in species richness and diversity ([Pysek et al.
2004](#ref-RN5423)), as rare synanthropic species have become rarer, and
neophytes have increased their abundance at the expense of natives and
archaeophytes ([Lososova & Simonova 2008](#ref-RN5441)).

Antropogenic vegetation is likely to be similar within ecological
regions (ecoregions, hereafter), since they are assumed to encompass
areas with a similar biogeographic history and recurrent local
ecosystems ([**RN5491?**](#ref-RN5491)). However, ecoregional-scale
studies on the diversity of antropogenic vegetation are scarce in the
literature. The Iberian Atlantic ecoregion (a.k.a. Cantabrian Mixed
Forests ecoregion; NW Iberian Peninsula) has a long history of human
habitation dating back to the Cantabrian Upper Paleolithic ([Straus
2005](#ref-RN5450)). This, together with its transitional position at
the border between the temperate and Mediterranean climatic zones of
Europe ([Loidi 2017](#ref-RN4700)), suggests a long regional history for
archaeophyte-rich anthropogenic plant communities, likely supporting a
current high diversity of anthropogenic plant communities with both
temperate and Mediterranean floristic elements ([Díaz González
2020](#ref-RN5008)). Historical trade links with America and Asia,
together with the warm and humid temperate climate, have made the region
a hotspot for neophyte invasions ([**RN5492?**](#ref-RN5492);
[**RN5493?**](#ref-RN5493)). Recent post-industrial land-use changes
have left large areas with abandoned industrial sites (i.e. brownfields)
whose management and restoration requires an understanding of
anthropogenic communities able to colonize or restore them ([Gallego et
al. 2016](#ref-RN5448); [Matanzas et al. 2021](#ref-RN5449)). Although
there is a long tradition of studying weed and ruderal communities in
the ecoregion ([Aedo et al. 1988](#ref-RN5364); [González et al.
1988](#ref-RN5360); [Merino, González, González, et al.
1988](#ref-RN5359); [Merino, González, Morales, et al.
1988](#ref-RN5361)) there is a current need for an ecoregional-level
synthesis that revises and updates the classification and updates in
accord with recent developments in European vegetation science ([Mucina
et al. 2016](#ref-RN4698)) and habitat classification ([Chytrý et al.
2020](#ref-RN5061)). In this article we have performed such a synthesis
with two main objectives: (1) provide an updated classification of
anthropogenic plant communities in the Iberian Atlantic ecoregion, and
(2) describe the main patterns of vegetation diversity in terms of
floristic origin (natives, archaeophytes, neophytes); life forms;
functional traits (plant height and flowering time); and ecological
indicator values (temperature, moisture, light, nutrients, soil
reaction, disturbance frequency and disturbance severity).

# Methods

We performed all data management and analysis with R version 4.3.1 ([R
Core Team 2023](#ref-RN5387)), using the R package *tidyverse* ([Wickham
et al. 2019](#ref-RN4662)) for data processing and visualization. We
homogenized all taxon names in the analysis and the article using
Euro+Med ([2006](#ref-RN5044)) or Plants of the World Online for taxa
not in Euro+Med ([POWO 2023](#ref-RN5376)). For the nomenclature of
sintaxa we follow Mucina *et al.* ([2016](#ref-RN4698)) for alliances
and higher ranks, and Rivas-Martínez *et al.* ([2001](#ref-RN4697)) for
associations. The original datasets, as well as R code for analysis and
creation of the manuscript can be accessed at the GitHub repository
<https://github.com/efernandezpascual/manmade>.

## Study ecoregion

We studied the anthropogenic plant communities of the Iberian Atlantic
ecoregion ([Fernández Prieto et al. 2020](#ref-RN5372)), i.e. the
territories with a temperate climate in the north-western Iberian
Peninsula. Our study ecoregion broadly corresponds with the Cantabrian
Mixed Forests ecoregion *sensu* Olson *et al.* ([2001](#ref-RN4667)),
with the Iberian part of the European Atlantic province *sensu*
Rivas-Martínez *et al.* ([2017](#ref-RN4699)) and with the Iberian
section of the Atlantic biogeographical region of the European
Environmental Agency
(<https://www.eea.europa.eu/data-and-maps/figures/biogeographical-regions-in-europe-2>).

## Definition of anthropogenic vegetation

To circumscribe our study vegetation, we followed the definition of
anthropogenic vegetation in the recent classification of the vegetation
of Europe by Mucina *et al.* ([2016](#ref-RN4698)). In our study area,
this potentially includes the vegetation classes *Polygono-Poetea
annuae*, *Papaveretea rhoeadis*, *Digitario sanguinalis-Eragrostietea
minoris*, *Chenopodietea*, *Sisymbrietea*, *Bidentetea*, *Artemisietea
vulgaris* and *Epilobietea angustifolii*. To these, and for a complete
synthesis, we added to our study the class *Cymbalario-Parietarietea
diffusae* included by Mucina *et al.* ([2016](#ref-RN4698)) in the
vegetation of rock crevices and screes, since this class encompasses the
vegetation of human-made walls.

## Checklist of anthropogenic sintaxa

To assist in our classification, we prepared a checklist of
anthropogenic sintaxa that could potentially be present in our study
ecoregion (**Supplementary 1**), based on regional sintaxonomical
checklists ([Izco et al. 2000](#ref-RN5363); [Díaz González
2020](#ref-RN5008); [Gómez 2020](#ref-RN5365)) and recent revisions at
the European level ([Mucina et al. 2016](#ref-RN4698); [Preislerová et
al. 2022](#ref-RN5371)). The checklist inclused 38 anthropogenic
vegetation alliances that could be present in the Iberian Atlantic
ecoregion (**Supplementary 2**). A goal of our study was to validate the
presence of these alliances in our ecoregion, and to assign to them the
existing vegetation data.

## Vegetation data selection

We retrieved anthropogenic vegetation plots from SIVIM, the Iberian and
Macaronesian Vegetation Information System ([Font et al.
2012](#ref-RN5374)). To identify plots as anthropogenic, we selected
those plots that had been classified by the original authors of the plot
as belonging to any sintaxa in our sintaxonomical checklist. However,
since not all plots in SIVIM have an assigned sintaxon, we also
retrieved additional plots using the expert system created by Chytrý *et
al.* ([2020](#ref-RN5061)) to classify vegetation plots into EUNIS
pan-European habitat types. This expert system uses the floristic
composition of plots to assign them to habitat types depending on the
presence and abundance of characteristic species. We retrieved plots
that had been assigned to any habitat related to the vegetation classes
we had previously defined: all habitats in the level 1 code V (vegetated
man-made habitats), plus level 3 codes R55 (lowland moist or wet
tall-herb and fern fringe) and R57 (herbaceous forest clearing
vegetation). It must be noted that habitats R55 and R57 include
communities that are classified as *grasslands and lands dominated by
forbs, mosses or lichens * by EUNIS but as *anthropogenic vegetation* by
by Mucina *et al.* ([2016](#ref-RN4698)). The extraction from SIVIM
produced an initial pool of 3,160 vegetation plots, to which we added 89
vegetation plots of urban or peri-urban plant communities sampled by us
or extracted from local literature not in SIVIM ([Zabaleta Mendizábal
1990](#ref-RN5377); [Uría Arizaga 2020](#ref-RN5378)).

## Vegetation data cleaning

We performed an exploratory analysis of these 3,249 plots using Two-Way
Indicator Species Analysis (TWINSPAN) ([Roleček et al.
2009](#ref-RN5379)). We used the R package *twinspanR* ([Zelený
2021](#ref-RN5380)) to do the TWINSPANs in this article, using 3
pseudospecies cut levels (0, 15, 25) with a minimum group size of 10
plots and Sørensen’s average dissimilarity. During this exploratory
analysis we identified 741 outlier plots which either did not belong to
the target anthropogenic vegetation or to the geographical area of the
ecoregion. The majority of these plots corresponded to coastal plant
communities and had been misclassified by the expert system. We removed
these, leaving a dataset of 2,508 vegetation plots for data analysis:
2,419 plots from SIVIM, originally recorded in 89 publications
(**Supplementary 3**); plus 89 plots added by us.

## Training dataset for semi-supervised classification and validation of alliances

To create a training dataset for semi-supervised classification (see
below), we started by keeping only those plots (n = 2,201) that had been
assigned by the original authors of the plot as belonging to any of the
38 alliances in our sintaxonomical checklist (i.e., we removed the plots
without sintaxa, that had been retrieved solely by the expert system).
We further cleaned this subset by subjecting it to a preliminary
numerical classification using TWINSPAN, in which we attempted to match
the plots into the 38 alliances our sintaxonomical checklist. This step
allowed us to identify those plots in which there was an agreement
between (1) our TWINSPAN-based classification and (2) the classification
based on the original-author sintaxa; these plots (n = 1,725) became our
training dataset for semi-supervised classification. Furthermore, this
step allowed us to validate which alliances from our sintaxonomical
checklist were present in the study ecoregion (n = 28) and which were
absent (n = 10).

## Semi-supervised classification

Next, we conducted a semi-supervised classification of the whole dataset
(n = 2,508 plots) into the 28 validated anthropogenic alliances.
Semi-supervised classification uses a training subset of *a priori*
classified vegetation plots to classify a secondary subset of
unclassified plots ([De Cáceres et al. 2010](#ref-RN5383)). Since our
goal was to refine the classification of the whole dataset, we allowed
plots from the training subset to be re-assigned to other alliances
during the classification. In addition, semi-supervised classification
can create new groups to place data points that do not match the already
existing *a priori* groups, but attempts to do so resulted in new groups
with no ecological significance, and thus we kept the 28 alliances as
final vegetation groups. Furthermore, we applied a noise clustering
fuzzy algorithm, which allows the plots to be classified either into the
*a priori* alliances or into a *noise* group which includes outliers and
transitional plots ([Wiser & De Cáceres 2013](#ref-RN5382)). We set the
fuzziness coefficient to a low value (m = 1) to accommodate a high
number of transitional plots; and we set the distance to the noise class
to d = 1. We performed this analysis with the R package *vegclust* ([De
Cáceres et al. 2010](#ref-RN5383)). The semi-supervised classification
with noise clustering resulted in the final classification of 2,081
plots into 28 alliances and 427 plots left out in the noise group. We
used pairwise PERMANOVA (with 100,000 iterations, Euclidean distances
and Holm’s p-value correction) fitted with the R package *RVAideMemoire*
([Herve 2023](#ref-RN5381)) to test the significance of the final
vegetation alliances; along with Principal Component Analysis (PCA) as
implemented in the R package *FactoMineR* ([Lê et al.
2008](#ref-RN3166)) to visualize the relationships between the
alliances.

## Characteristic species and EUNIS habitat regionalization

We calculated sets of characteristic species ([Chytrý et al.
2020](#ref-RN5061)) for each of the final 28 vegetation alliances. We
defined dominant species as species with more than 25% cover in at least
5% of the vegetation plots of the group; constant species as species
with a frequency higher than 50% in the group; and diagnostic species as
species with an *IndVal* value with a p-value lower than 0.05, as
calculated with the R package *labdsv* ([Roberts 2016](#ref-RN2311))
using 1.000.000 iterations. Additionally, we assigned to each alliance a
regionalized level 4 EUNIS habitat code, using pre-existing codes when
they existed
(<https://eunis.eea.europa.eu/habitats-code-browser-revised.jsp>), and
creating new codes when not.

## Species origin as native, archaeophyte and neophyte

We classified the species as native, archaophytes and neophytes using
the information in *Flora iberica* ([1987](#ref-RN3243)) and catalogues
of archaeophytes for Britain ([**RN5490?**](#ref-RN5490)) and the Czech
Republic ([**RN5495?**](#ref-RN5495)). We must stress that identifying
archaeophytes is southern Europe is highly problematic and our
classification must be taken as an indication of putative archaeophyte
character for the purposes of vegetation description, rather than a
definitive classification of the species.

## Species life form

From *FloraVeg.EU* ([2023](#ref-RN5385)) we extracted the species’ life
forms and kept *therophyte* and *geophyte* for further analysis since
these two categories had the largest contribution to variance as per an
exploratory Principal Component Analysis (PCA) performed using the R
package *FactoMineR* ([Lê et al. 2008](#ref-RN3166)).

## Species and vegetation height and flowering phenology

From *Flora iberica* ([1987](#ref-RN3243)) we extracted the maximum
height, median month of flowering and length of the flowering period of
each species in the dataset. We used these to calculate plot-level
community-weighted means (weighting by species cover) for each trait, to
characterize the vegetation height and flowering phenology of the
anthropogenic plant communities.

## Species ecological indicator values

We collected, for each species in the dataset, its ecological indicator
values of temperature, moisture, light, nutrients and soil reaction
([Dengler et al. 2023](#ref-RN5384)); and its disturbance frequency and
severity indicator values ([Midolo et al. 2023](#ref-RN5101)). To those
species lacking an indicator value in the accessed references, we
assigned a value by reciprocal averaging, i.e. by (1) calculating
weighted average values of the species with values for each plot
(weighting by species cover), and (2) assigning to the missing species
the weighted average values of the plots where they were present
(weighting by species cover). Then, for each vegetation plot, we
calculated the plot-level mean of each indicator value.

# Results

## Overview of the classification

The semi-supervised classification resulted in the classification of
2,081 vegetation plots into 28 anthropogenic alliances of the Iberian
Atlantic ecoregion (**Table 1**, **Figure 1**). Most of the alliances
had a wide distribution in the ecoregion according to our dataset,
although five of them (*Caucalidion lappulae*, *Linario
polygalifoliae-Vulpion alopecuri*, *Convolvulo arvensis-Agropyrion
repentis*, *Senecionion fluviatilis*, *Paspalo-Agrostion
semiverticillati*) had only isolated occurrences in a few points towards
the southern limit of the Iberian Atlantic territories. The regional
literature included in our dataset recognized 72 associations
(**Supplementary 4**) within these alliances.

Focusing on the classified plots, the dataset included 1,167 taxa or
taxa aggregates. Of these, 101 were neophytes (i.e. 9% of the species
pool). Regarding life forms, the species pool was dominated by
hemicryptophytes (43%) and therophytes (41%). The 10 most frequent
species were *Ochlopoa annua* (621 occurrences), *Urtica dioica* (592),
*Sonchus oleraceus* (540), *Stellaria media* (516), *Capsella
bursa-pastoris* (390), *Polygonum aviculare* (375), *Dactylis glomerata*
(363), *Senecio vulgaris* (332) and *Anisantha sterilis* (301).
Considering only those plots with the most frequent plot size (20
m<sup>2</sup>, n = 256 plots), the average species richness per plot was
16 (minimum = 3, maximum = 37).

DCA ordination of the floristic composition of the classified plots
(**Fig. 2**) suggested a high consistency of the vegetation classes
*Cymbalario-Parietarietea diffusae*, *Polygono-Poetea annuae*,
*Papaveretea rhoeadis*, *Digitario sanguinalis-Eragrostietea minoris*,
*Sisymbrietea* and *Bidentetea*. The alliances belonging to the two
perennial ruderal vegetation classes (*Artemisietea vulgaris* and
*Epilobietea angustifolii*) were mixed together. The winter-annual class
*Chenopodietea* also showed high heterogeneity, especially because of
the isolation of the altered dune alliance *Linario
polygalifoliae-Vulpion alopecuri*.

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
disturbances and shadier areas (classes *Cymbalario-Parietarietea
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

***Bidentetea*** Summer-annual pioneer vegetation of temporarily-flooded
sites.

16. *Bidention tripartitae* Summer-annual pioneer vegetation of
    temporarily-flooded sites. Occupies nutrient-richer sites than the
    other alliance in the class and has a higher proportion of
    therophytes (**Fig. 4**). Dispersed throughout the ecoregion (**Fig.
    1**). Diagnostic species (**Supplementary 5**): *Persicaria
    hydropiper*, *Bidens frondosus*, *Lythrum salicaria*.

17. *Paspalo-Agrostion semiverticillati* Summer-annual pioneer
    vegetation of temporarily-flooded and warm sites. Occupies warmer
    and wetter situations than the other alliance in the class, has a
    higher proportion of neophytes and has a longer flowering season
    (**Fig. 4**). Isolated occurrences in the south of the ecoregion
    (**Fig. 1**). Diagnostic species (**Supplementary 5**): *Paspalum
    distichum*, *Cyperus longus*, *Schoenoplectus lacustris*.

***Artemisietea vulgaris*** Perennial ruderal vegetation of dry sites.

18. *Convolvulo arvensis-Agropyrion repentis* Semiruderal grasslands.
    Occupies wetter and shadier situations than the other alliances in
    the class, and has a higher proportion of geophytes and grasses
    (**Fig. 4**). Isolated occurrence in the south of the ecoregion
    (**Fig. 1**). Diagnostic species (**Supplementary 5**): *Poa
    compressa*, *Elytrigia repens*, *Potentilla reptans*, *Valerianella
    locusta*.

19. *Carduo carpetani-Cirsion odontolepidis* Thistle ruderal vegetation
    of warm sites. Occupies warmer situations than the other thistle
    alliance in the class (**Fig. 4**). Mostly distributed in the
    Cantabrian Mountains (**Fig. 1**). Diagnostic species
    (**Supplementary 5**): *Onopordum acanthium*.

20. *Cirsion richterano-chodati* Thistle ruderal vegetation of cold
    sites. Occupies colder situations than the other thistle alliance in
    the class (**Fig. 4**). Mostly distributed in the Cantabrian
    Mountains (**Fig. 1**). Diagnostic species (**Supplementary 5**):
    *Cirsium eriophorum*, *Carduus carpetanus*, *Carduus nutans* aggr.

21. *Dauco-Melilotion* Biennial ruderal vegetation. Occupies wetter
    situations than the two thistle alliances in the class, and has a
    higher proportion of therophytes (**Fig. 4**). Sparse occurrence
    throughout the ecoregion (**Fig. 1**). Diagnostic species
    (**Supplementary 5**): *Helminthotheca echioides*, *Daucus carota*,
    *Melilotus albus*, *Foeniculum vulgare*.

***Epilobietea angustifolii*** Perennial ruderal vegetation of mesic to
wet sites.

22. *Geo urbani-Alliarion officinalis* Low-herb short-lived semiruderal
    and fringe vegetation. Occupies shadier and less disturbed
    situations than the other alliances in the class, and has a higher
    proportion of therophytes and shorter plants (**Fig. 4**). Wide
    distribution in the ecoregion (**Fig. 1**). Diagnostic species
    (**Supplementary 5**): *Urtica dioica*.

23. *Arction lappae* Low-herb short-lived ruderal vegetation. Occupies
    sunnier and more frequently-disturbed situations than the other
    alliances in the class, and has a higher proportion of therophytes
    and shorter plants (**Fig. 4**). Distribution concentrated in the
    Cantabrian Mountains (**Fig. 1**). Diagnostic species
    (**Supplementary 5**): *Oxybasis rubra*, *Senecio duriaei*.

24. *Balloto-Conion maculati* Tall-herb perennial ruderal vegetation.
    Occupies warmer situations than the other alliances in the class
    (**Fig. 4**). Distribution concentrated in the Cantabrian Mountains
    and the east of the ecoregion (**Fig. 1**). Diagnostic species
    (**Supplementary 5**): *Sambucus ebulus*.

25. *Aegopodion podagrariae* Tall-herb perennial vegetation of forest
    margins and clearings. Occupies shadier and less disturbed
    situations than the other alliances in the class (**Fig. 4**).
    Sparse occurrence throughout the ecoregion (**Fig. 1**). Diagnostic
    species (**Supplementary 5**): *Anthriscus sylvestris*, *Heracleum
    sphondylium*, *Galium aparine*.

26. *Epilobion angustifolii* Tall-herb perennial vegetation of forest
    margins and clearings in acidic soils. Occupies colder,
    nutrient-poorer, more acidic and less disturbed situations than the
    other alliances in the class (**Fig. 4**). Distributed towards the
    west of the ecoregion (**Fig. 1**). Diagnostic species
    (**Supplementary 5**): *Epilobium angustifolium*, *Digitalis
    purpurea*, *Luzula lactea*.

27. *Cynancho-Convolvulion sepium* Tall-herb vegetation of nutrient-rich
    riparian habitats. Occupies wetter situations and less disturbed
    situations than the other alliances in the class, and has a later
    flowering season (**Fig. 4**). Dispersed throughout the ecoregion
    (**Fig. 1**). Diagnostic species (**Supplementary 5**): *Eupatorium
    cannabinum*, *Angelica sylvestris*, *Picris hieracioides*.

28. *Senecionion fluviatilis* Tall-herb vegetation of nutrient-rich
    river banks and ditches. Occupies warmer and wetter situations than
    the other alliances in the class, flowers later, has taller plants
    and is highly dominated by neophytes and geophytes (**Fig. 4**).
    Isolated occurrence in the western coast of the ecoregion (**Fig.
    1**). Diagnostic species (**Supplementary 5**): *Arundo donax*,
    *Silene latifolia*.

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

Segetal vegetation of Palestine ([**RN5494?**](#ref-RN5494)).

History of synanthropic veg in czech ([**RN5496?**](#ref-RN5496))

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

<img src="../results/figures/F1 - maps.png" alt="Figure 1. Anthropogenic vegetation alliances of the Iberian Atlantic ecoregion. Each dot is a vegetation plot. Dot colors indicate the vegetation class." width="4251" />
<p class="caption">
<span id="fig:fig1"></span>Figure 1: Figure 1. Anthropogenic vegetation
alliances of the Iberian Atlantic ecoregion. Each dot is a vegetation
plot. Dot colors indicate the vegetation class.
</p>

</div>

<div class="figure">

<img src="../results/figures/F2 - pca.png" alt="Figure 2. Floristic composition of the anthropogenic plant communities of the Iberian Atlantic ecoregion. Biplots produced by Principal Component Analysis (PCA) with Hellinger transformation. PCAs were conducted for the whole vegetation (A) and for specific subsets (B-F). Colors indicate the vegetation class." width="4251" />
<p class="caption">
<span id="fig:fig2"></span>Figure 2: Figure 2. Floristic composition of
the anthropogenic plant communities of the Iberian Atlantic ecoregion.
Biplots produced by Principal Component Analysis (PCA) with Hellinger
transformation. PCAs were conducted for the whole vegetation (A) and for
specific subsets (B-F). Colors indicate the vegetation class.
</p>

</div>

<div class="figure">

<img src="../results/figures/F3 - origins.png" alt="Figure 3. Proportion of neophytes, archaeophytes and native species in the anthropogenic plant communities of the Iberian Atlantic ecoregion. Each bar represents the plot-level average proportion of neophytes (dark shade), archaeophytes (medium shade) and natives (light shade) in each vegetation alliance. Colors indicate the vegetation class." width="4251" />
<p class="caption">
<span id="fig:fig3"></span>Figure 3: Figure 3. Proportion of neophytes,
archaeophytes and native species in the anthropogenic plant communities
of the Iberian Atlantic ecoregion. Each bar represents the plot-level
average proportion of neophytes (dark shade), archaeophytes (medium
shade) and natives (light shade) in each vegetation alliance. Colors
indicate the vegetation class.
</p>

</div>

<div class="figure">

<img src="../results/figures/F4 - lifeforms.png" alt="Figure 4. Proportion of therophytes, geophytes and other life forms in the anthropogenic plant communities of the Iberian Atlantic ecoregion. Each bar represents the plot-level average proportion of therophytes (dark shade), geophytes (medium shade) and other life forms (light shade) in each vegetation alliance. Colors indicate the vegetation class." width="4251" />
<p class="caption">
<span id="fig:fig4"></span>Figure 4: Figure 4. Proportion of
therophytes, geophytes and other life forms in the anthropogenic plant
communities of the Iberian Atlantic ecoregion. Each bar represents the
plot-level average proportion of therophytes (dark shade), geophytes
(medium shade) and other life forms (light shade) in each vegetation
alliance. Colors indicate the vegetation class.
</p>

</div>

<div class="figure">

<img src="../results/figures/F5 - height-flowering.png" alt="Figure 5. Vegetation heigh and flowering phenology of the anthropogenic plant communities of the Iberian Atlantic ecoregion. Boxplots show the community-weighted mean for plant heigh, month of peak flowering and length of the flowering season for each vegetation alliance. Colors indicate the vegetation class." width="4251" />
<p class="caption">
<span id="fig:fig5"></span>Figure 5: Figure 5. Vegetation heigh and
flowering phenology of the anthropogenic plant communities of the
Iberian Atlantic ecoregion. Boxplots show the community-weighted mean
for plant heigh, month of peak flowering and length of the flowering
season for each vegetation alliance. Colors indicate the vegetation
class.
</p>

</div>

<div class="figure">

<img src="../results/figures/F6 - indicators.png" alt="Figure 6. Ecological requirements of the anthropogenic plant communities of the Iberian Atlantic ecoregion. Boxplots show the plot-level means for the ecological indicator values of temperature, moisture, light, nutrients, soil reaction, disturbance frequency and disturbance severity, calculated for each vegetation alliance. Colors indicate the vegetation class." width="4251" />
<p class="caption">
<span id="fig:fig6"></span>Figure 6: Figure 6. Ecological requirements
of the anthropogenic plant communities of the Iberian Atlantic
ecoregion. Boxplots show the plot-level means for the ecological
indicator values of temperature, moisture, light, nutrients, soil
reaction, disturbance frequency and disturbance severity, calculated for
each vegetation alliance. Colors indicate the vegetation class.
</p>

</div>

<div class="figure">

<img src="../results/figures/F7 - pca.png" alt="Figure 7. Pattern of variation in the ecological requirements of the anthropogenic plant communities of the Iberian Atlantic ecoregion. Biplot produced by Principal Component Analysis (PCA) of the plot-level means for the ecological indicator values of temperature, moisture, light, nutrients, soil reaction, disturbance frequency and disturbance severity. Labels and arrows indicate the contribution of each indicator to the first and second principal components. Colors indicate the vegetation class." width="4228" />
<p class="caption">
<span id="fig:fig7"></span>Figure 7: Figure 7. Pattern of variation in
the ecological requirements of the anthropogenic plant communities of
the Iberian Atlantic ecoregion. Biplot produced by Principal Component
Analysis (PCA) of the plot-level means for the ecological indicator
values of temperature, moisture, light, nutrients, soil reaction,
disturbance frequency and disturbance severity. Labels and arrows
indicate the contribution of each indicator to the first and second
principal components. Colors indicate the vegetation class.
</p>

</div>
