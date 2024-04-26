Anthropogenic plant communities of the Iberian Atlantic ecoregion
================

Running title: Iberian Atlantic anthropogenic vegetation

Eduardo Fernández-Pascual<sup>1,a</sup>
(<https://orcid.org/0000-0002-4743-9577>), Víctor
González-García<sup>1</sup> (<https://orcid.org/0000-0002-8949-7943>),
Greta Ivesdal<sup>2</sup>, Adrián Lázaro-Lobo<sup>1</sup>
(<https://orcid.org/0000-0002-0509-2085>), Borja
Jiménez-Alfaro<sup>1</sup> (<https://orcid.org/0000-0001-6601-9597>)

<sup>1</sup> Biodiversity Research Institute (IMIB), University of
Oviedo - CSIC - Principality of Asturias, Mieres, Spain; <sup>2</sup>
Jardín Botánico Atlántico, Gijón/Xixón, Spain

Correspondence: Eduardo Fernández-Pascual, Instituto Mixto de
Investigación en Biodiversidad, Campus de Mieres, Edificio de
Investigación, 5ª planta, c/ Gonzalo Gutiérrez Quirós s/n, E-33600
Mieres, Spain. Email: <fernandezpeduardo@uniovi.es>. Telephone:
+34985104781.

# Author contributions

Eduardo Fernández-Pascual: Conceptualization; Methodology; Data
Curation; Formal Analysis; Visualization; Writing – Original Draft
Preparation; Writing – Review & Editing. Víctor González-García:
Methodology; Investigation; Formal Analysis; Writing – Review & Editing.
Greta Ivesdal: Investigation; Formal Analysis; Writing – Review &
Editing. Adrián Lázaro-Lobo: Investigation; Writing – Review & Editing.
Borja Jiménez-Alfaro: Methodology; Writing – Review & Editing.

# Funding

Ayuntamiento de Gijón/Xixón, Jardín Botánico Atlántico
(SV-23-GIJON-JBA).

# Conflict of interest statement

None declared.

# Data availability statement

Original datasets, R code for analysis and Rmarkdown code for creation
of the manuscript can be accessed at the GitHub repository
<https://github.com/efernandezpascual/manmade>. Upon publication, a
version of record of the repository will be deposited in Zenodo.

# Abstract (300 words max.)

- *Questions* Which is the diversity of anthropogenic plant communities
  at the ecoregional level in a transitional territory between temperate
  and Mediterranean Europe? How are these communities composed by native
  plants, archaeophytes and neophytes? What are the main environmental
  and disturbance drivers of the diversity in anthropogenic vegetation?

- *Location* Iberian Atlantic ecoregion, Iberian Peninsula,
  south-western Europe.

- *Methods* We compiled a vegetation database of 2,508 synanthropic
  plots and revised the regional checklist of anthropogenic alliances.
  We used modified TWINSPAN and semi-supervised classification to
  classify the plots into the revised alliances. We determined the
  proportion of natives, archaeophytes and neophytes. We described the
  alliances in terms of vegetation height, flowering phenology and
  ecological requirements for temperature, moisture, light, nutrients,
  soil reaction, disturbance frequency and disturbance severity.

- *Results* We classified 2,081 vegetation plots into 28 anthropogenic
  alliances representing 9 vegetation classes (*Cymbalario-Parietarietea
  diffusae*, *Polygono-Poetea annuae*, *Papaveretea rhoeadis*,
  *Digitario sanguinalis-Eragrostietea minoris*, *Chenopodietea*,
  *Sisymbrietea*, *Bidentetea*, *Artemisietea vulgaris* and *Epilobietea
  angustifolii*). The plots included 1,162 vascular plant taxa: 78 %
  natives, 15 % archaeophytes and 7 % neophytes. The main ecological
  gradients behind this diversity went from dry-sunny to moist-shady
  habitats, followed by a gradient of low to high disturbance frequency
  and severity.

- *Conclusions* The human-made habitats of the Iberian Atlantic
  ecoregion host one third of the ecoregional species pool and one fifth
  of the Iberian flora. Wet anthropogenic habitats are most affected by
  neophyte invasions. Annual vegetation of arable lands is a refuge for
  archaeophytes. Mesic perennial ruderal vegetation is specially rich in
  native species and can be a biodiversity asset in urban and peri-urban
  settings.

# Keywords (10 max)

Synanthropic vegetation, human-made habitats, urban biodiversity,
neophytes, archaeophytes, alien plants, biological invasions, habitat
classification, semi-supervised classification

# Introduction

Anthropogenic vegetation is the set of plant communities that occur as a
direct consequence of human activities, and is chiefly composed by the
weed vegetation of arable fields and the ruderal vegetation of human
settlements and their surroundings ([Lososová & Simonova
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
solutions such as bioremediation and restoration of degraded
post-industrial landscapes ([Song et al. 2019](#ref-RN5447)).

The anthropogenic vegetation of temperate Europe is formed by an
original pool of native species favored by humans, but this pool has
been constantly enriched by the arrival of alien species ([Pokorná et
al. 2018](#ref-RN5504)). First, by archaeophytes, whose arrival started
in the Neolithic and peaked in the Bronze Age, with successive increases
during periods of accelerated human colonization such as the early
Middle Ages ([Pokorná et al. 2018](#ref-RN5504)). Synanthropic
archaeophytes include many Mediterranean taxa originated within the
segetal flora of the Near East ([Zohary 1950](#ref-RN5494)). Some of
these archaeophytes are ‘obligate weeds’ that do not have
non-anthropogenic habitats and that are assumed to have evolved together
with human agriculture ([Zohary 1950](#ref-RN5494)). Archaeophytes
started their expansion into temperate areas during the Mid-Holocene
warm period, but it is difficult to disentangle to what extent this
expansion was favored by human activities and/or ongoing climatic
changes ([Cayless & Tipping 2002](#ref-RN5443); [Cordova & Lehmann
2003](#ref-RN5432)), especially in southern European areas close to the
transition between the Mediterranean and the temperate climates
([Celesti‐Grapow et al. 2009](#ref-RN5444)). The synanthropic flora of
Europe has been further enriched by neophytes, alien taxa that arrived
from the start of the Modern Age (after 1.500 A.D.) to the present day
([Brun 2009](#ref-RN5439)). Synanthropic neophytes include many
American, African and Asian taxa that got to Europe as a consequence of
the global trade networks established by the Western European colonial
powers ([Lenzner et al. 2022](#ref-RN5451)). In the last century, the
European anthropogenic vegetation has shown a decrease in species
richness and diversity ([Pyšek et al. 2004](#ref-RN5423)), as rare
synanthropic species have become rarer, and neophytes have increased
their abundance at the expense of natives and archaeophytes ([Lososová &
Simonova 2008](#ref-RN5441)).

Anthropogenic vegetation is likely to be similar within ecological
regions (ecoregions, hereafter), since they are assumed to encompass
areas with a similar biogeographic history and recurrent local
ecosystems ([Bailey 2004](#ref-RN5491)). However, ecoregional-scale
studies on the diversity of anthropogenic vegetation are scarce in the
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
a hotspot for neophyte invasions ([Fernández de Castro et al.
2018](#ref-RN5492); [Lázaro-Lobo et al. 2024](#ref-RN5493)). Recent
post-industrial land-use changes have left large areas with abandoned
industrial sites (i.e. brownfields) whose management and restoration
requires an understanding of anthropogenic communities able to colonize
or restore them ([Gallego et al. 2016](#ref-RN5448); [Matanzas et al.
2021](#ref-RN5449)). Although there is a long tradition of studying weed
and ruderal communities in the ecoregion ([Aedo et al.
1988](#ref-RN5364); [Fernández González et al. 1988](#ref-RN5360);
[Penas Merino, Díaz González, García González, et al.
1988](#ref-RN5359); [Penas Merino, Díaz González, Pérez Morales, et al.
1988](#ref-RN5361)) there is a current need for an ecoregional-level
synthesis that revises and updates the classification in accord with
recent developments in European vegetation science ([Mucina et al.
2016](#ref-RN4698)) and habitat classification ([Chytrý et al.
2020](#ref-RN5061)). In this article, we have performed such a synthesis
with the following objectives: (1) provide an updated classification of
anthropogenic plant communities in the Iberian Atlantic ecoregion; (2)
quantify the proportion of natives, archaeophytes and neophytes in
different anthropogenic plant communities; (3) characterize the plant
communities in terms of life forms, plant height and flowering
phenology; (4) describe the ecological requirements of the different
communities (temperature, moisture, light, nutrients, soil reaction,
disturbance frequency and disturbance severity); and (5) provide a
summary description of each of the plant communities.

# Methods

## Data curation and taxonomic criteria

We performed all data management and analysis with R version 4.3.1 ([R
Core Team 2023](#ref-RN5387)), using the R package *tidyverse* ([Wickham
et al. 2019](#ref-RN4662)) for data processing and visualization. We
homogenized all taxon names in the analysis and the article using
Euro+Med ([Euro+Med 2006](#ref-RN5044)) or Plants of the World Online
([POWO 2023](#ref-RN5376)) for taxa not in Euro+Med. For the
nomenclature of sintaxa, we followed Mucina *et al.*
([2016](#ref-RN4698)) for alliances and higher ranks, and Rivas-Martínez
*et al.* ([2001](#ref-RN4697)) for associations. The original datasets,
as well as R code for analysis and creation of the manuscript, can be
accessed at the GitHub repository
<https://github.com/efernandezpascual/manmade>.

## Study ecoregion

We studied the anthropogenic plant communities of the Iberian Atlantic
ecoregion ([Fernández Prieto et al. 2020](#ref-RN5372)), i.e. the
territories with a temperate climate in the north-western part of the
Iberian Peninsula. Our study ecoregion broadly corresponds with the
Cantabrian Mixed Forests ecoregion *sensu* Olson *et al.*
([2001](#ref-RN4667)), with the Iberian part of the European Atlantic
province *sensu* Rivas-Martínez *et al.* ([2017](#ref-RN4699)) and with
the Iberian section of the Atlantic biogeographical region of the
European Environmental Agency
(<https://www.eea.europa.eu/data-and-maps/figures/biogeographical-regions-in-europe-2>).

## Definition of anthropogenic vegetation

To circumscribe our study vegetation, we followed the definition of
anthropogenic vegetation in the recent classification of the vegetation
of Europe by Mucina *et al.* ([2016](#ref-RN4698)). In our study area,
this potentially includes the vegetation classes *Polygono-Poetea
annuae*, *Papaveretea rhoeadis*, *Digitario sanguinalis-Eragrostietea
minoris*, *Chenopodietea*, *Sisymbrietea*, *Bidentetea*, *Artemisietea
vulgaris* and *Epilobietea angustifolii*. To these, and for a complete
synthesis, we added the class *Cymbalario-Parietarietea diffusae*
included by Mucina *et al.* ([2016](#ref-RN4698)) in the vegetation of
rock crevices and screes, since this class encompasses the vegetation of
human-made walls.

## Checklist of anthropogenic sintaxa

To assist in our classification, we prepared a checklist of
anthropogenic sintaxa that could be present in our study ecoregion
(**Appendix S1**), based on regional sintaxonomical checklists ([Izco et
al. 2000](#ref-RN5363); [Díaz González 2020](#ref-RN5008); [Durán Gómez
2020](#ref-RN5365)) and recent revisions at the European level ([Mucina
et al. 2016](#ref-RN4698); [Preislerová et al. 2022](#ref-RN5371)). The
sintaxonomical checklist included 38 anthropogenic vegetation alliances
that could be present in the Iberian Atlantic ecoregion. A goal of our
study was to validate the presence of these alliances in the ecoregion,
and to assign to them the existing vegetation data.

## Vegetation data selection

We retrieved Iberian Atlantic anthropogenic vegetation plots from SIVIM,
the Iberian and Macaronesian Vegetation Information System ([Font et al.
2012](#ref-RN5374)). To identify plots as anthropogenic, we selected
those plots that had been classified by the original authors of the plot
as belonging to any sintaxa in our sintaxonomical checklist. However,
since not all plots in SIVIM have an assigned sintaxon, we also
retrieved additional plots using the expert system created by Chytrý *et
al.* ([2020](#ref-RN5061)) to classify vegetation plots into EUNIS
pan-European habitat types. We retrieved plots that had been assigned to
any habitat related to the vegetation classes we had previously defined:
all habitats in the level 1 code *V Vegetated man-made habitats*, plus
level 3 codes *R55 Lowland moist or wet tall-herb and fern fringe* and
*R57 Herbaceous forest clearing vegetation*. It must be noted that
habitats *R55* and *R57* include communities that are classified as *R
Grasslands and lands dominated by forbs, mosses or lichens* by EUNIS but
as *Anthropogenic vegetation* by Mucina *et al.* ([2016](#ref-RN4698)).
The extraction from SIVIM produced an initial pool of 3,160 vegetation
plots, to which we added 89 vegetation plots of urban or peri-urban
plant communities sampled by us or extracted from local literature not
in SIVIM ([Zabaleta Mendizábal 1990](#ref-RN5377); [Uría Arizaga
2020](#ref-RN5378)).

## Vegetation data cleaning

We performed an exploratory analysis of these 3,249 plots using modified
Two-Way Indicator Species Analysis (TWINSPAN) ([Roleček et al.
2009](#ref-RN5379)). We used the R package *twinspanR* ([Zelený
2021](#ref-RN5380)) for TWINSPAN, with 3 pseudospecies cut levels (0,
15, 25), a minimum group size of 10 plots and Sørensen’s average
dissimilarity. During this exploratory analysis we identified 741
outlier plots which did not belong to either the target anthropogenic
vegetation or to the geographical area of the ecoregion. The majority of
these plots corresponded to coastal plant communities and had been
misclassified by the expert system. We removed these, leaving a dataset
of 2,508 vegetation plots for data analysis: 2,419 plots from SIVIM,
originally recorded in 89 publications (**Appendix S2**); plus 89 plots
added by us.

## Training dataset for semi-supervised classification and validation of alliances

To create a training dataset for semi-supervised classification (see
below), we started by keeping only those plots (n = 2,201) that had been
assigned by the original authors of the plot as belonging to any of the
38 alliances in our sintaxonomical checklist (i.e., we removed the plots
without sintaxa, that had been retrieved solely by the expert system).
We further cleaned this subset by subjecting it to a preliminary
numerical classification using TWINSPAN, in which we attempted to match
the plots into the 38 alliances in our sintaxonomical checklist. This
step allowed us to identify those plots in which there was an agreement
between (1) our TWINSPAN-based classification and (2) the classification
based on the original author’s sintaxon; these plots (n = 1,725) became
our training dataset for semi-supervised classification. Furthermore,
this step allowed us to validate which alliances from our sintaxonomical
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
fuzzy algorithm, which allows plots to be classified either into the *a
priori* alliances or into a *noise* group which includes outliers and
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
2008](#ref-RN3166)) to visualize the relationships between the classes
and alliances.

## Characteristic species and EUNIS habitat correspondence

To facilitate the usage of the classification by local managers and
environmental consultants, we calculated sets of characteristic species
(**Appendix S3**) ([Chytrý et al. 2020](#ref-RN5061)) for each of the
final 28 vegetation alliances. We defined dominant species as species
with more than 25% cover in at least 5% of the vegetation plots of the
group; constant species as species with a frequency higher than 50% in
the group; and diagnostic species as species with an *IndVal* value with
a p-value lower than 0.05, as calculated with the R package *labdsv*
([Roberts 2016](#ref-RN2311)) using 1.000.000 iterations. Additionally,
we assigned to each alliance its correspondence to level-3 EUNIS habitat
codes (<https://eunis.eea.europa.eu/habitats-code-browser-revised.jsp>).

## Species origin as native, archaeophyte and neophyte

We classified the species as native, archaeophytes and neophytes in the
Iberian Atlantic ecoregion using the information in *Flora iberica*
([1987](#ref-RN3243)) and catalogues of archaeophytes for Britain
([Preston et al. 2004](#ref-RN5490)) and the Czech Republic ([Chytrý et
al. 2021](#ref-RN5495)). We must stress that identifying archaeophytes
in southern Europe is highly problematic and our classification must be
taken as an indication of putative archaeophyte character for the
purposes of vegetation description, rather than a definitive
classification of the species: as stated by Preston *et al.* ([Preston
et al. 2004](#ref-RN5490)), the classification of a species as an
archaeophyte should be interpreted as a hypothesis to be tested by
further studies.

## Species life form

From *FloraVeg.EU* ([2023](#ref-RN5385)) we extracted the species’ life
forms and kept *therophyte* and *geophyte* for further analysis since
these two categories had the largest contribution to variance as per an
exploratory Principal Component Analysis (PCA) performed using the R
package *FactoMineR* ([Lê et al. 2008](#ref-RN3166)).

## Species height and flowering phenology

From *Flora iberica* ([1987](#ref-RN3243)) we extracted the maximum
height, median month of flowering and length of the flowering period of
each species in the dataset. We used these variables to calculate
plot-level community-weighted means (weighting by species cover) for
each trait, to characterize the vegetation height and flowering
phenology of the anthropogenic plant communities.

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
2,081 vegetation plots into 28 anthropogenic alliances (**Fig. 1**)
representing 9 vegetation classes. Most of the alliances had a wide
distribution in the ecoregion according to our dataset, but five of them
(*Caucalidion lappulae*, *Linario polygalifoliae-Vulpion alopecuri*,
*Convolvulo arvensis-Agropyrion repentis*, *Senecionion fluviatilis* and
*Paspalo-Agrostion semiverticillati*) had isolated occurrences in a few
points towards the southern limit of the Iberian Atlantic territories.
The regional literature included in our dataset recognized 72
associations (**Appendix S4**) within these alliances, but exploratory
analysis (not shown) indicated that the separation of these associations
within the alliances had a generally weak support based on numerical
classification methods.

The classified plots included 1,162 taxa or taxa aggregates. The 10 most
frequent species were *Ochlopoa annua* (621 occurrences), *Urtica
dioica* (592), *Sonchus oleraceus* (540), *Stellaria media* (516),
*Capsella bursa-pastoris* (390), *Polygonum aviculare* (375), *Dactylis
glomerata* (363), *Senecio vulgaris* (332) and *Anisantha sterilis*
(301). Considering only those plots with the most frequent plot size (20
m<sup>2</sup>, n = 256 plots), the average species richness per plot was
16 (minimum = 3, maximum = 37). The class with the richest species pool
was *Epilobietea angustifolii* (n = 615) and the poorest was
*Cymbalario-Parietarietea diffusae* (n = 171).

PCA ordination of the floristic composition of the classified plots
(**Fig. 2A**) suggested a high consistency of three major vegetation
groups: (1) trampled vegetation of class *Polygono-Poetea annuae*; (2)
crop weeds of classes *Papaveretea rhoeadis* and *Digitario
sanguinalis-Eragrostietea minoris*; and (3) perennial ruderal vegetation
of classes *Artemisietea vulgaris* and *Epilobietea angustifolii*. The
central position of the floristic space, between these three major
groups, was occupied by the annual ruderal vegetation of classes
*Chenopodietea*, *Sisymbrietea* and *Bidentetea*; as well as by the wall
vegetation of class *Cymbalario-Parietarietea diffusae*. Separate PCAs
within the major vegetation groups indicated a coherent separation
between most of the alliances, but with some cases of relatively high
overlap: for example, between (i) *Galio valantiae-Parietarion judaicae*
and *Cymbalario-Asplenion*; (ii) *Geo urbani-Alliarion officinalis* and
*Aegopodion podagrariae*.

## Proportion of natives, archaeophytes and neophytes

The total synanthropic species pool (n = 1,162) was composed of 78 %
natives (n = 908), 15 % putative archaeophytes (n = 178) and 7 %
neophytes (n = 76). The most frequent putative archaeophytes were
*Capsella bursa-pastoris* (390 occurrences), *Senecio vulgaris* (332),
*Anisantha sterilis* (301), *Anthemis arvensis* (280), *Hordeum murinum*
(274), *Raphanus raphanistrum* (233), *Vicia sativa* (228), *Malva
sylvestris* (197), *Sisymbrium officinale* (166) and *Echinochloa
crus-galli* (165); while the most frequent neophytes were *Veronica
persica* (212), *Erigeron canadensis* (138), *Amaranthus hybridus* (73),
*Oxalis corniculata* (67), *Lepidium didymum* (57), *Oxalis latifolia*
(51), *Paspalum distichum* (48), *Bidens frondosus* (35), *Cyperus
eragrostis* (34) and *Symphyotrichum squamatum* (33).

By vegetation class, *Epilobietea angustifolii* had the highest
proportion of natives in its species pool (82 %); *Sisymbrietea* had the
highest proportion of putative archaeophytes (31 %); and *Bidentetea*
had the highest proportion of neophytes (17 %). The alliances with the
highest proportions of archaeophytes in their species pools were
*Caucalidion lappulae* (41 %), *Chenopodion muralis* (35 %) and
*Sisymbrion officinalis* (31 %); while the alliances with the highest
proportion of neophytes were *Bidention tripartitae* (19 %), *Allion
triquetri* (12 %) and *Spergulo arvensis-Erodion cicutariae* (10%).

Focusing on plot-level average proportions (**Fig. 3**), the alliances
with the most archaeophytes were *Caucalidion lappulae*, *Spergulo
arvensis-Erodion cicutariae* and *Sisymbrion officinalis*, in which only
about half of the plot-level proportion was made up of native species.
The alliances with the highest plot-level proportion of neophytes were
*Bidention tripartitae*, *Paspalo-Agrostion semiverticillati* and
*Senecionion fluviatilis*. Some alliances had high proportions of native
species, e.g. *Epilobion angustifolii*, *Convolvulo arvensis-Agropyrion
repentis* and *Linario polygalifoliae-Vulpion alopecuri*.

## Community-level traits

The most frequent life form in the species pool (n = 1,162 species) were
hemicryptophytes (44 %), followed by therophytes (42 %), geophytes (9
%), chamaephytes (6 %), phanerophytes (6 %), bryophytes (1 %) and
hydrophytes (1 %). The proportion of therophytes across classes and
alliances (**Fig. 4**) agreed with the traditional description of the
sintaxa. Thus, therophytes dominated the annual communities of
trampled-soil vegetation (*Polygono-Poetea annuae*), crops weeds
(*Papaveretea rhoeadis*, *Digitario sanguinalis-Eragrostietea minoris*)
and annual ruderals (*Chenopodietea*, *Sisymbrietea*, *Bidentetea*);
while perennial life forms (especially hemicryptophytes) dominated walls
(*Cymbalario-Parietarietea diffusae*) and perennial ruderal vegetation
(*Artemisietea vulgaris*, *Epilobietea angustifolii*). Geophytes were a
relatively high proportion of the vegetation in three alliances: *Allion
triquetri*, *Convolvulo arvensis-Agropyrion repentis* and *Senecionion
fluviatilis*.

Community-weighted means for plant height (**Fig. 5A**) also agreed with
the expected description of the sintaxa. The shortest communities were
the dwarf-herb vegetation of trampled sites (*Polygono-Poetea annuae*,
average height = 45.2 cm) and crop weeds (*Papaveretea rhoeadis*, 55.4
cm), while the tallest were the perennial ruderal vegetation of dry
(*Artemisietea vulgaris*, 129 cm) and mesic (*Epilobietea angustifolii*,
136 cm) sites. The median month of flowering (**Fig. 5B**) was May
(*Sisymbrietea*, *Chenopodietea*, *Papaveretea rhoeadis*), June
(*Cymbalario-Parietarietea diffusae*, *Polygono-Poetea annuae*,
*Epilobietea angustifolii*, *Artemisietea vulgaris*) or July (*Digitario
sanguinalis-Eragrostietea minoris*, *Bidentetea*). The length of the
flowering season (**Fig. 5C**) was generally high, from 5 months
(*Artemisietea vulgaris*, *Epilobietea angustifolii*) to 6
(*Chenopodietea*, *Sisymbrietea*), 7 (*Bidentetea*, *Digitario
sanguinalis-Eragrostietea minoris*, *Papaveretea rhoeadis*), 8
(*Polygono-Poetea annuae*) or 9 (*Cymbalario-Parietarietea diffusae*).

## Community-level ecological preferences

To visualize the major patterns of variation in the ecological and
disturbance preferences of the different communities (**Fig. 6**) we
performed a PCA ordination of plot-level means (**Fig. 7**). The first
two PCA axes explained 59 % of the variability. The major contributors
to axis 1 (36 % variance explained) were light, nutrient and moisture
requirements; it separated communities of open, dry and comparatively
nutrient-poorer sites (classes *Papaveretea rhoeadis*, *Polygono-Poetea
annuae*, *Sisymbrietea*, *Artemisietea vulgaris*, *Chenopodietea* and
*Digitario sanguinalis-Eragrostietea minoris*) from communities of
shady, moist and nutrient-richer sites (classes
*Cymbalario-Parietarietea diffusae*, *Bidentetea* and *Epilobietea
angustifolii*). The major contributors to axis 2 (23% variance
explained) were disturbance severity and frequency; this axis separated
communities preferring low severity - low frequency disturbances
(classes *Cymbalario-Parietarietea diffusae*, *Epilobietea
angustifolii*, *Chenopodietea*, *Artemisietea vulgaris* and
*Bidentetea*) from communities adapted to high severity - high frequency
disturbances (classes *Papaveretea rhoeadis*, *Polygono-Poetea annuae*,
*Sisymbrietea* and *Digitario sanguinalis-Eragrostietea minoris*).

## Description of the Iberian Atlantic anthropogenic communities

***Cymbalario-Parietarietea diffusae*** Vegetation of human-made walls.

1.  *Galio valantiae-Parietarion judaicae* Hemicryptophyte-rich
    vegetation of walls. Occupies slightly warmer and sunnier situations
    than the other alliance in the class and has a shorter flowering
    season. Wide distribution in the ecoregion. Diagnostic species in
    the ecoregion: *Parietaria judaica*, *Centranthus ruber*, *Asplenium
    trichomanes*. Correspondence with EUNIS (2012) habitat *J2.5 -
    Constructed boundaries*.

2.  *Cymbalario-Asplenion* Fern-rich vegetation of walls. Occupies
    slightly colder and shadier walls than the other alliance in the
    class and has a longer flowering season. Wide distribution in the
    ecoregion. Diagnostic species in the ecoregion: *Cymbalaria
    muralis*. Correspondence with EUNIS (2012) habitat *J2.5 -
    Constructed boundaries*.

***Polygono-Poetea annuae*** Dwarf-herb vegetation of heavily-trampled
sites.

3.  *Polycarpion tetraphylli* Dwarf-annual trampled vegetation of warm
    and sunny sites. Occupies warmer, sunnier and nutrient-poorer
    situations than the other alliances in the class and has an earlier
    flowering season. Wide distribution in the ecoregion, specially
    along the coast and in submediterranean valleys of the interior.
    Diagnostic species in the ecoregion: *Sagina apetala*, *Plantago
    coronopus*, *Crassula tillaea*, *Spergularia marina*. Correspondence
    with EUNIS habitat *V34 Trampled xeric grassland with annuals*.

4.  *Polygono-Coronopodion* Annual trampled vegetation of dry sites.
    Occupies sites that are colder than those favored by *Polycarpion
    tetraphylli*, but drier than those of *Saginion procumbentis*. Has a
    specially high proportion of neophytes. Wide distribution in the
    ecoregion. Diagnostic species in the ecoregion: *Matricaria
    suaveolens*, *Polygonum aviculare*. Correspondence with EUNIS
    habitat *V34 Trampled xeric grassland with annuals*.

5.  *Saginion procumbentis* Bryophyte-rich trampled vegetation of mesic
    sites. Occupies colder and wetter situations than the other
    alliances in the class, is less dominated by therophytes and has a
    relatively high proportion of bryophytes. Distribution concentrated
    in the central part of the ecoregion. Diagnostic species in the
    ecoregion: *Sagina procumbens*, *Bryum argenteum*. Correspondence
    with EUNIS habitat *V35 Trampled mesophilous grassland with
    annuals*.

***Papaveretea rhoeadis*** Annual weed vegetation of crops and gardens.

6.  *Caucalidion lappulae* Annual weed vegetation of cereal crops on
    base-rich soils. Very high proportion of putative archaeophytes.
    Distribution mostly limited to the more submediterranean valleys
    south of the Cantabrian Mountains. Diagnostic species in the
    ecoregion: *Cyanus segetum*, *Papaver rhoeas*, *Trifolium arvense*,
    *Anacyclus clavatus*, *Valerianella eriocarpa*. Correspondence with
    EUNIS habitats *V11 Intensive unmixed crops* and *V13 Arable land
    with unmixed crops grown by low-intensity agricultural methods*.

7.  *Scleranthion annui* Annual weed vegetation of cereal crops on
    base-poor soils. Occupies more acidic soils than the other alliances
    in the class, and flowers earlier. High proportion of putative
    archaeophytes. Wide distribution in the ecoregion, but specially in
    the west, where acidic bedrocks dominate. Diagnostic species in the
    ecoregion: *Mibora minima*, *Rumex acetosella*. Correspondence with
    EUNIS habitats *V11 Intensive unmixed crops*, *V12 Mixed crops of
    market gardens and horticulture*, *V13 Arable land with unmixed
    crops grown by low-intensity agricultural methods* and *V15 Bare
    tilled, fallow or recently abandoned arable land*.

8.  *Oxalidion europeae* Annual weed vegetation of gardens and root
    crops. Occupies wetter, shadier and nutrient-richer situations than
    the other alliances in the class, has a longer flowering season.
    High proportion of putative archaeophytes, and more neophytes than
    the other alliances in the class. Wide distribution in the
    ecoregion. Diagnostic species in the ecoregion: *Stellaria media*,
    *Veronica persica*. Correspondence with EUNIS habitats *V11
    Intensive unmixed crops*, *V12 Mixed crops of market gardens and
    horticulture*, *V13 Arable land with unmixed crops grown by
    low-intensity agricultural methods* and *V15 Bare tilled, fallow or
    recently abandoned arable land*.

***Digitario sanguinalis-Eragrostietea minoris*** Summer-annual C4 weed
vegetation.

9.  *Spergulo arvensis-Erodion cicutariae* Summer-annual C4 weed
    vegetation. Late-flowering alliance rich in neophytes and grasses,
    occurring in highly-disturbed and nutrient-rich sites. Wide
    distribution in the ecoregion. Diagnostic species in the ecoregion:
    *Digitaria sanguinalis*, *Echinochloa crus-galli*, *Chenopodium
    album*, *Amaranthus hybridus*. Correspondence with EUNIS habitats
    *V11 Intensive unmixed crops*, *V12 Mixed crops of market gardens
    and horticulture* and *V13 Arable land with unmixed crops grown by
    low-intensity agricultural methods*.

***Chenopodietea*** Winter-annual fringe and ruderal vegetation.

10. *Allion triquetri* Geophyte-rich fringe vegetation. This vegetation
    occupies warmer, shadier and less frequently disturbed situations
    than other alliances in the class, and is comparatively taller and
    earlier-flowering. Has a higher proportion of geophytes and a lower
    proportion of therophytes. The proportion of neophytes is the
    highest in the class. Wide distribution in the ecoregion. Diagnostic
    species in the ecoregion: *Urtica membranacea*, *Smyrnium
    olusatrum*, *Tradescantia fluminensis*. Correspondence with EUNIS
    habitat *V37 Annual anthropogenic herbaceous vegetation*.

11. *Geranio pusilli-Anthriscion caucalidis* Winter-annual fringe
    vegetation. Occupies situations similar to the previous alliance,
    but in colder sites, and is a shorter vegetation dominated by
    therophytes instead of geophytes. Mostly distributed in the
    submediterranean valleys south of the Cantabrian Mountains.
    Diagnostic species in the ecoregion: *Geranium lucidum*, *Anthriscus
    caucalis*. Correspondence with EUNIS habitat *V37 Annual
    anthropogenic herbaceous vegetation*.

12. *Chenopodion muralis* Low-growth winter-annual ruderal vegetation.
    Short vegetation occupying colder situations than the other
    alliances in the class and more disturbed sites. Flowers longer and
    later. Has a high proportion of archaeophytes. Sparse occurrence
    throughout the ecoregion. Diagnostic species in the ecoregion:
    *Malva neglecta*, *Urtica urens*. Correspondence with EUNIS habitat
    *V37 Annual anthropogenic herbaceous vegetation*.

13. *Echio-Galactition tomentosae* Tall-herb winter-annual ruderal
    vegetation. Occupies drier, sunnier and less nutrient-rich
    situations than other alliances in the class. Mostly distributed in
    the west of the ecoregion. Diagnostic species in the ecoregion:
    *Galactites tomentosus*, *Coleostephus myconis*, *Anisantha rigida*.
    Correspondence with EUNIS habitat *V37 Annual anthropogenic
    herbaceous vegetation*.

14. *Linario polygalifoliae-Vulpion alopecuri* Ephemeral annual
    vegetation of disturbed coastal dunes. Occupies warm, dry and sunny
    coastal sites, and has a high number of coastal dune species.
    Isolated occurrence in the southern coast of the ecoregion.
    Diagnostic species in the ecoregion: *Vulpia alopecuros*, *Malcolmia
    littorea*, *Crucianella maritima*, *Artemisia campestris*.
    Correspondence with EUNIS habitat *V32 Mediterranean subnitrophilous
    annual grassland*.

***Sisymbrietea*** Summer-annual ruderal vegetation.

15. *Sisymbrion officinalis* Summer-annual ruderal vegetation. Rich in
    therophytes and archaeophytes and adapted to severe disturbances.
    Wide distribution in the ecoregion. Diagnostic species in the
    ecoregion: *Hordeum murinum*, *Sisymbrium officinale*.
    Correspondence with EUNIS habitats *V15 Bare tilled, fallow or
    recently abandoned arable land* and *V37 Annual anthropogenic
    herbaceous vegetation*.

***Bidentetea*** Summer-annual pioneer vegetation of temporarily flooded
sites.

16. *Bidention tripartitae* Summer-annual pioneer vegetation of
    temporarily flooded sites. Occupies nutrient-richer sites than the
    other alliance in the class and has a higher proportion of
    therophytes and neophytes. Dispersed throughout the ecoregion.
    Diagnostic species in the ecoregion: *Persicaria hydropiper*,
    *Bidens frondosus*, *Lythrum salicaria*. Correspondence with EUNIS
    habitat *Q61 Periodically exposed shore with stable, eutrophic
    sediments with pioneer or ephemeral vegetation*.

17. *Paspalo-Agrostion semiverticillati* Summer-annual pioneer
    vegetation of temporarily flooded and warm sites. Occupies wetter
    and more frequently disturbed sites than the other alliance in the
    class and has a longer flowering season. Isolated occurrences in the
    south of the ecoregion. Diagnostic species in the ecoregion:
    *Paspalum distichum*, *Cyperus longus*, *Schoenoplectus lacustris*.
    Correspondence with EUNIS habitat *R55 Lowland moist or wet
    tall-herb and fern fringe*.

***Artemisietea vulgaris*** Perennial ruderal vegetation of dry sites.

18. *Convolvulo arvensis-Agropyrion repentis* Semiruderal grasslands.
    Occupies wetter, shadier and nutrient-poorer situations than the
    other alliances in the class, and has a higher proportion of
    geophytes, grasses and native species. Isolated occurrence in the
    south of the ecoregion. Diagnostic species in the ecoregion: *Poa
    compressa*, *Elytrigia repens*, *Potentilla reptans*, *Valerianella
    locusta*. Correspondence with EUNIS habitat *V38 Dry perennial
    anthropogenic herbaceous vegetation*.

19. *Carduo carpetani-Cirsion odontolepidis* Thistle ruderal vegetation
    of warm sites. Occupies warmer situations than the other thistle
    alliance in the class and has a high proportion of archaeophytes.
    Mostly distributed in the Cantabrian Mountains. Diagnostic species
    in the ecoregion: *Onopordum acanthium*. Correspondence with EUNIS
    habitat *V38 Dry perennial anthropogenic herbaceous vegetation*.

20. *Cirsion richterano-chodati* Thistle ruderal vegetation of cold
    sites. Occupies colder situations than the other thistle alliance in
    the class. Mostly distributed in the Cantabrian Mountains.
    Diagnostic species in the ecoregion: *Cirsium eriophorum*, *Carduus
    carpetanus*, *Carduus nutans*. Correspondence with EUNIS habitat
    *V38 Dry perennial anthropogenic herbaceous vegetation*.

21. *Dauco-Melilotion* Biennial ruderal vegetation. Occupies wetter
    situations than the two thistle alliances in the class and has a
    higher proportion of neophytes. Occurrence throughout the ecoregion.
    Diagnostic species in the ecoregion: *Helminthotheca echioides*,
    *Daucus carota*, *Melilotus albus*, *Foeniculum vulgare*.
    Correspondence with EUNIS habitat *V38 Dry perennial anthropogenic
    herbaceous vegetation*.

***Epilobietea angustifolii*** Perennial fringe and ruderal vegetation
of mesic to wet sites.

22. *Geo urbani-Alliarion officinalis* Low-herb short-lived semiruderal
    and fringe vegetation. Occupies shadier and less frequently
    disturbed situations than the other alliances in the class and has a
    higher proportion of therophytes and shorter plants. Wide
    distribution in the ecoregion. Diagnostic species in the ecoregion:
    *Urtica dioica*. Correspondence with EUNIS habitat *V39 Mesic
    perennial anthropogenic herbaceous vegetation*.

23. *Arction lappae* Low-herb short-lived ruderal vegetation. Occupies
    sunnier and more frequently disturbed situations than the other
    alliances in the class, and has a higher proportion of therophytes
    and shorter plants. Distribution concentrated in the Cantabrian
    Mountains. Diagnostic species in the ecoregion: *Oxybasis rubra*,
    *Senecio duriaei*. Correspondence with EUNIS habitat *V39 Mesic
    perennial anthropogenic herbaceous vegetation*.

24. *Balloto-Conion maculati* Tall-herb perennial ruderal vegetation.
    Occupies warmer situations than the other alliances in the class.
    Has a high proportion of archaeophytes. Distribution concentrated in
    the Cantabrian Mountains and the east of the ecoregion. Diagnostic
    species in the ecoregion: *Sambucus ebulus*. Correspondence with
    EUNIS habitat *V39 Mesic perennial anthropogenic herbaceous
    vegetation*.

25. *Aegopodion podagrariae* Tall-herb perennial vegetation of forest
    margins and clearings. Occupies shadier and less disturbed
    situations than the other alliances in the class. Sparse occurrence
    throughout the ecoregion. Diagnostic species in the ecoregion:
    *Anthriscus sylvestris*, *Heracleum sphondylium*, *Galium aparine*.
    Correspondence with EUNIS habitats *R55 Lowland moist or wet
    tall-herb and fern fringe* and *V39 Mesic perennial anthropogenic
    herbaceous vegetation*.

26. *Epilobion angustifolii* Tall-herb perennial vegetation of forest
    margins and clearings in acidic soils. Occupies colder,
    nutrient-poorer, more acidic and less disturbed situations than the
    other alliances in the class. Distributed towards the west of the
    ecoregion. Diagnostic species in the ecoregion: *Epilobium
    angustifolium*, *Digitalis purpurea*, *Luzula lactea*.
    Correspondence with EUNIS habitats *R54 Pteridium aquilinum
    vegetation* and *R57 Herbaceous forest clearing vegetation*.

27. *Cynancho-Convolvulion sepium* Tall-herb fringe vegetation of
    nutrient-rich riparian habitats. Occupies wetter and less disturbed
    situations than the other alliances in the class and has a later
    flowering season. Dispersed throughout the ecoregion. Diagnostic
    species in the ecoregion: *Eupatorium cannabinum*, *Angelica
    sylvestris*, *Picris hieracioides*. Correspondence with EUNIS
    habitat *R55 Lowland moist or wet tall-herb and fern fringe*.

28. *Senecionion fluviatilis* Tall-herb vegetation of nutrient-rich
    riverbanks and ditches. Occupies warmer and wetter situations than
    the other alliances in the class, flowers later, has taller plants
    and has a high proportion of neophytes and geophytes. Isolated
    occurrence in the western coast of the ecoregion. Diagnostic species
    in the ecoregion: *Arundo donax*, *Silene latifolia*. Correspondence
    with EUNIS habitat *R55 Lowland moist or wet tall-herb and fern
    fringe*.

# Discussion

Our analysis supports the existence of 28 anthropogenic alliances in the
vegetation of the Iberian Atlantic ecoregion. While the core of this
vegetation diversity is made up of temperate European alliances, these
are enriched by the occurrence of eight Mediterranean alliances (*Galio
valantiae-Parietarion judaicae*, *Polycarpion tetraphylli*, *Allion
triquetri*, *Chenopodion muralis*, *Echio-Galactition tomentosae*,
*Paspalo-Agrostion semiverticillati*, *Balloto-Conion maculati* and
*Cynancho-Convolvulion sepium*); plus three alliances that are endemic
of the Iberian coasts (*Linario polygalifoliae-Vulpion alopecuri*) and
mountains (*Carduo carpetani-Cirsion odontolepidis*, *Cirsion
richterano-chodati*) ([Mucina et al. 2016](#ref-RN4698)). Seven of these
alliances had been reported as absent or uncertain in the ecoregion
(*Caucalidion lappulae*, *Chenopodion muralis*), or only present in the
Portuguese sector of the ecoregion (*Spergulo arvensis-Erodion
cicutariae*, *Allion triquetri*, *Echio-Galactition tomentosae*, *Carduo
carpetani-Cirsion odontolepidis*, *Cynancho-Convolvulion sepium*) by the
recently published distribution maps of vegetation alliances in Europe
([Preislerová et al. 2022](#ref-RN5371)). Our dataset supports that six
of these alliances are relatively well distributed in the ecoregion,
while *Caucalidion lappulae* only has isolated occurrences. On the other
hand, our dataset does not support the occurrence in the ecoregion of
nine Mediterranean alliances (*Roemerion hybridae*, *Diplotaxion
erucoidis*, *Euphorbion prostratae*, *Alysso granatensis-Brassicion
barrelieri*, *Hordeion murini*, *Taeniathero-Aegilopion geniculatae*,
*Parietarion lusitanico-mauritanicae*, *Onopordion castellani*, *Silybo
mariani-Urticion piluliferae*) and one temperate alliance (*Fragarion
vescae*) that had been cited as potentially occurring here ([Izco et al.
2000](#ref-RN5363); [Mucina et al. 2016](#ref-RN4698); [Díaz González
2020](#ref-RN5008); [Durán Gómez 2020](#ref-RN5365); [Preislerová et al.
2022](#ref-RN5371)). For habitat classification purposes, we propose
that this vegetation diversity can be summarized into 15 EUNIS habitat
types: one constructed habitat (*J2.5*), ten vegetated human-made
habitats (*V11*, *V12*, *V13*, *V15*, *V32*, *V35*, *V34*, *V37*, *V38*,
*V39*), three habitats of woodland fringes and clearings and tall forb
stands (*R54*, *R55*, *R57*) and one habitat of periodically-exposed
shores (*Q61*). In general, we have followed the correspondence between
alliances and EUNIS habitats proposed by the EUNIS expert system
([Chytrý et al. 2020](#ref-RN5061)), except for *Echio-Galactition
tomentosae* which, in the context of the ecoregion, we believe is more
adequately placed in the habitat *V37 Annual anthropogenic herbaceous
vegetation* rather than in the habitat *V33 Dry Mediterranean land with
unpalatable non-vernal herbaceous vegetation*.

Since our goal was to match the classification of the ecoregional
classification to the EuroVegChecklist ([Mucina et al.
2016](#ref-RN4698)), we refrained from merging recognized alliances or
changing their assignation to superior sintaxa. However, there are some
cases that could deserve further scrutiny. For example, the two wall
alliances (*Galio valantiae-Parietarion judaicae* and
*Cymbalario-Asplenion*) had a large overlap in their geographic
distribution, their floristic composition, their proportion of alien
species, their community traits and their ecological preferences. These
two alliances are well recognized in the European literature, and they
are generally interpreted as representing the Mediterranean (*Galio
valantiae-Parietarion judaicae*) and temperate (*Cymbalario-Asplenion*)
versions of wall vegetation ([Brullo & Guarino 1998](#ref-RN5369);
[Jasprica et al. 2021](#ref-RN5367)). It is therefore not surprising
that in boundary ecoregions - such as the Iberian Atlantic territories -
these two alliances coexist and show a high overlap. Also, there was
overlap between the alliances *Geo urbani-Alliarion officinalis* and
*Aegopodion podagrariae*, two alliances that can occupy ruderal to
semi-natural nitrophilous fringes, and which are mostly differentiated
by dominant vegetation height, as was supported by our dataset.

We found a percentage of 22 % non-native species in the anthropogenic
vegetation of the Iberian Atlantic ecoregion. This percentage is
intermediate between that found in urban areas of temperate Europe and
North America (30-50 %) ([Pyšek 1998](#ref-RN5499); [Clemants & Moore
2003](#ref-RN5500); [La Sorte et al. 2007](#ref-RN5498); [Lososová et
al. 2012](#ref-RN5079)) and Italy (12-26 %) ([Celesti-Grapow & Blasi
1998](#ref-RN5501)). A survey of anthropogenic vegetation in the
north-west Balkans found 13 % non-native plants, with more neophytes
than archaeophytes ([Silc et al. 2012](#ref-RN5429)). A similar study in
the Czech Republic found 32 % archaeophytes and 7 % neophytes ([Simonova
& Lososová 2008](#ref-RN5435)). Taken together, these results suggest
that the Iberian Atlantic anthropogenic vegetation shows an invasion
status that is intermediate between southern and central-northern
Europe, which is in agreement with the biogeographical position of our
ecoregion. Previous studies also suggested that the invasion status was
higher in early successional anthropogenic communities ([Pyšek et al.
2004](#ref-RN5423)), and our results confirmed this as the proportion of
native species tended to be higher in the perennial ruderal classes
*Artemisietea vulgaris* and *Epilobietea angustifolii*. The classes with
more alien species also tended to be those adapted to more frequent and
more severe disturbances (*Papaveretea rhoeadis*, *Digitario
sanguinalis-Eragrostietea minoris*, *Sisymbrietea*), also in agreement
with previous research ([Simonova & Lososová 2008](#ref-RN5435)). Of the
alien species, archaeophytes were a higher proportion in the vegetation
associated to arable habitats (*Papaveretea rhoeadis*, *Digitario
sanguinalis-Eragrostietea minoris*, *Sisymbrietea*), in agreement with
the ancient origin of archaeophytes during the development of
agriculture ([Zohary 1950](#ref-RN5494); [Preston et al.
2004](#ref-RN5490)). On the other hand, neophytes tended to be in higher
proportions in vegetation types associated to wet conditions
(*Bidentetea*), as has been found in other European regions ([Chytrý et
al. 2008](#ref-RN5497)).

The traits of the Iberian Atlantic anthropogenic communities agreed with
those found in other European regions ([Lososová et al.
2006](#ref-RN2297); [Silc 2010](#ref-RN5436)), with more annual species
in habitats associated to arable land and more perennials in ruderal
habitats, and a general dominance of therophytes and hemicryptophytes in
the species pool ([Tabasevic et al. 2021](#ref-RN5428)). We found that
the main drivers of variation in anthropogenic community composition was
a gradient from open-dry to shady-wet sites, supporting the importance
of the moisture gradient in shaping anthropogenic vegetation ([Golovanov
et al. 2023](#ref-RN5434)). Mesic and moist human-made habitats of the
Iberian Atlantic territories harbor perennial communities, some of which
are especially rich in native species and have semi-natural characters.
At the same time, the wetter habitats have some of the most invaded
communities.

# Conclusions

The anthropogenic vegetation of the Iberian Atlantic ecoregion is home
to 1,162 vascular plant taxa. This is approximately one third of the
whole ecoregional species pool represented in the SIVIM database ([Font
et al. 2012](#ref-RN5374)), or one fifth of the Iberian flora
([Ramos-Gutiérrez et al. 2021](#ref-RN5503)). More than half of this
synanthropic diversity (615 taxa) occurs in mesic to wet perennial
ruderal vegetation, highlighting the potential of some anthropogenic
habitats to act as source and supply of biodiversity in human-dominated
landscapes ([Anderson & Minor 2017](#ref-RN5446); [Kowarik
2018](#ref-RN5445)). These results suggest three main objectives for the
sustainable management of human-made habitats: (1) focusing efforts on
plant invasion management in anthropogenic plant communities of wet
habitats; (2) conserving examples of archaeophyte-rich annual weed
communities, especially those linked to traditional agricultural
practices ([Meyer et al. 2013](#ref-RN5502)); and (3) conserving and
promoting mesic ruderal and fringe vegetation as a biodiversity refuge
in urban and peri-urban areas.

# References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-RN5364" class="csl-entry">

Aedo, C., Herrera, M., Fernández Prieto, J., & Díaz González, T. 1988.
<span class="nocase">Datos sobre la vegetación arvense de la Cornisa
Cantábrica</span>. *Lazaroa* 9: 241–254.

</div>

<div id="ref-RN5446" class="csl-entry">

Anderson, E.C., & Minor, E.S. 2017. [<span class="nocase">Vacant lots:
An underexplored resource for ecological and social benefits in
cities</span>](https://doi.org/10.1016/j.ufug.2016.11.015). *Urban
Forestry & Urban Greening* 21: 146–152.

</div>

<div id="ref-RN5491" class="csl-entry">

Bailey, R.G. 2004. [<span class="nocase">Identifying ecoregion
boundaries</span>](https://doi.org/10.1007/s00267-003-0163-6).
*Environmental Management* 34: S14–S26.

</div>

<div id="ref-RN5369" class="csl-entry">

Brullo, S., & Guarino, R. 1998. <span class="nocase">Syntaxonomy of the
Parietarietea judaicae class in Europe</span>. *Annali di Botanica* 56:

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
Biosystems* 143: 386–430.

</div>

<div id="ref-RN5501" class="csl-entry">

Celesti-Grapow, L., & Blasi, C. 1998. <span class="nocase">A comparison
of the urban flora of different phytoclimatic regions in Italy</span>.
*Global Ecology & Biogeography Letters* 7: 367–378.

</div>

<div id="ref-RN5495" class="csl-entry">

Chytrý, M., Danihelka, J., Kaplan, Z., Wild, J., Holubová, D., Novotný,
P., Řezníčková, M., Rohn, M., Dřevojan, P., & Grulich, V. 2021.
<span class="nocase">Pladias database of the Czech flora and
vegetation</span>. *Preslia* 93: 1–87.

</div>

<div id="ref-RN5497" class="csl-entry">

Chytrý, M., Maskell, L.C., Pino, J., Pyšek, P., Vilà, M., Font, X., &
Smart, S.M. 2008. [<span class="nocase">Habitat invasions by alien
plants: a quantitative comparison among Mediterranean, subcontinental
and oceanic regions of
Europe</span>](https://doi.org/10.1111/j.1365-2664.2007.01398.x).
*Journal of Applied Ecology* 45: 448–458.

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

<div id="ref-RN5500" class="csl-entry">

Clemants, S., & Moore, G. 2003. <span class="nocase">Patterns of species
diversity in eight northeastern United States cities</span>. *Urban
habitats* 1:

</div>

<div id="ref-RN5432" class="csl-entry">

Cordova, C.E., & Lehmann, P.H. 2003.
[<span class="nocase">Archaeopalynology of synanthropic vegetation in
the chora of Chersonesos, Crimea,
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
Principado de Asturias (España)</span>. *Boletín de Ciencias de la
Naturaleza del RIDEA* 55: 339–646.

</div>

<div id="ref-RN5365" class="csl-entry">

Durán Gómez, J.A. 2020. <span class="nocase">Sintaxonomía de las
comunidades vegetales de Cantabria</span>. *Flora Montiberica* 56–92.

</div>

<div id="ref-RN5044" class="csl-entry">

Euro+Med. 2006. <span class="nocase">Euro+Med PlantBase - the
information resource for Euro-Mediterranean plant diversity.
http://ww2.bgbm.org/EuroPlusMed/</span>.

</div>

<div id="ref-RN5492" class="csl-entry">

Fernández de Castro, A.G., Navajas, A., & Fagúndez, J. 2018.
[<span class="nocase">Changes in the potential distribution of invasive
plant species in continental Spain in response to climate
change</span>](https://doi.org/10.1080/17550874.2018.1507053). *Plant
Ecology & Diversity* 11: 349–361.

</div>

<div id="ref-RN5360" class="csl-entry">

Fernández González, T.E., Penas Merino, Á., Herrero Cembranos, L., Pérez
Morales, C., Llamas García, F., & Terrón Alfonso, A. 1988.
<span class="nocase">Estudio de los herbazales nitrófilos vivaces y
comunidades ruderal viarios de la provincia de León (NW de
España)</span>. *Acta Botanica Barcinonensia*

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
of the class *Polygono arenastri- Poetea annuae* in the Russian
Federation</span>](https://doi.org/10.14258/turczaninowia.26.2.13).
*Turczaninowia* 26: 147–169.

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

<div id="ref-RN5367" class="csl-entry">

Jasprica, N., Škvorc, Ž., Pandža, M., Milović, M., Purger, D.,
Krstonošić, D., Kovačić, S., Sandev, D., Lasić, A., & Caković, D. 2021.
<span class="nocase">Phytogeographic and syntaxonomic diversity of wall
vegetation ( *Cymbalario-Parietarietea diffusae*) in southeastern
Europe</span>. *Plant Biosystems* 155: 622–631.

</div>

<div id="ref-RN2300" class="csl-entry">

Johnson, A.L., Borowy, D., & Swan, C.M. 2017. <span class="nocase">Land
use history and seed dispersal drive divergent plant community assembly
patterns in urban vacant lots</span>. *Journal of Applied Ecology*. doi:
[10.1111/1365-2664.12958](https://doi.org/10.1111/1365-2664.12958)

</div>

<div id="ref-RN5433" class="csl-entry">

Kostryukova, A.M., Mashkova, I.V., Krupnova, T.G., & Shchelkanova, E.E.
2017. [<span class="nocase">Study of synanthropic plants of the south
Ural</span>](https://doi.org/10.21660/2017.40.3519). *International
Journal of Geomate* 13: 60–65.

</div>

<div id="ref-RN5445" class="csl-entry">

Kowarik, I. 2018. [<span class="nocase">Urban wilderness: Supply,
demand, and access</span>](https://doi.org/10.1016/j.ufug.2017.05.017).
*Urban Forestry & Urban Greening* 29: 336–347.

</div>

<div id="ref-RN5498" class="csl-entry">

La Sorte, F.A., Mckinney, M.L., & Pyšek, P. 2007.
[<span class="nocase">Compositional similarity among urban floras within
and across continents: biogeographical consequences of human-mediated
biotic
interchange</span>](https://doi.org/10.1111/j.1365-2486.2007.01329.x).
*Global Change Biology* 13: 913–921.

</div>

<div id="ref-RN5493" class="csl-entry">

Lázaro-Lobo, A., Campos, J.A., Díaz González, T.E., Fernández-Pascual,
E., González García, V., Marchante, H., Romero, M.I., & Jiménez-Alfaro,
B. 2024. <span class="nocase">An ecoregion-based approach to evaluate
invasive species pools</span>. *NeoBiota*

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

<div id="ref-RN2297" class="csl-entry">

Lososová, Z., Chytrý, M., Kühn, I., Hájek, O., Horáková, V., Pyšek, P.,
& Tichý, L. 2006. [<span class="nocase">Patterns of plant traits in
annual vegetation of man-made habitats in central
Europe</span>](https://doi.org/10.1016/J.PPEES.2006.07.001).
*Perspectives in Plant Ecology, Evolution and Systematics* 8: 69–81.

</div>

<div id="ref-RN5079" class="csl-entry">

Lososová, Z., Chytrý, M., Tichý, L., Danihelka, J., Fajmon, K., Hájek,
O., Kintrová, K., Kühn, I., Láníková, D., Otýpková, Z., & Řehořek, V.
2012. [<span class="nocase">Native and alien floras in urban habitats: a
comparison across 32 cities of central
Europe</span>](https://doi.org/10.1111/j.1466-8238.2011.00704.x).
*Global Ecology and Biogeography* 21: 545–555.

</div>

<div id="ref-RN5441" class="csl-entry">

Lososová, Z., & Simonova, D. 2008. [<span class="nocase">Changes during
the 20th century in species composition of synanthropic vegetation in
Moravia (Czech Republic)</span>](<Go to ISI>://WOS:000259902900004).
*Preslia* 80: 291–305.

</div>

<div id="ref-RN5449" class="csl-entry">

Matanzas, N., Afif, E., Díaz González, T.E., & Gallego, J.R. 2021.
[<span class="nocase">Phytoremediation potential of native herbaceous
plant species growing on a paradigmatic brownfield
site</span>](https://doi.org/10.1007/s11270-021-05234-9). *Water, Air, &
Soil Pollution* 232: 290.

</div>

<div id="ref-RN5502" class="csl-entry">

Meyer, S., Wesche, K., Krause, B., & Leuschner, C. 2013.
[<span class="nocase">Dramatic losses of specialist arable plants in
Central Germany since the 1950s/60s – a cross-regional
analysis</span>](https://doi.org/10.1111/ddi.12102). *Diversity and
Distributions* 19: 1175–1187.

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

<div id="ref-RN4667" class="csl-entry">

Olson, D.M., Dinerstein, E., Wikramanayake, E.D., Burgess, N.D., Powell,
G.V., Underwood, E.C., D’amico, J.A., Itoua, I., Strand, H.E., &
Morrison, J.C. 2001. <span class="nocase">Terrestrial ecoregions of the
world: a new map of life on earth: a new global map of terrestrial
ecoregions provides an innovative tool for conserving
biodiversity</span>. *BioScience* 51: 933–938.

</div>

<div id="ref-RN5359" class="csl-entry">

Penas Merino, Á., Díaz González, T.E., García González, M.E., López
Pacheco, M.J., & Puente, E. 1988. <span class="nocase">Datos sobre los
cardales y tobales ( *Onopordetea acanthi*) en la provincia de
León</span>. *Lazaroa* 10: 987–88.

</div>

<div id="ref-RN5361" class="csl-entry">

Penas Merino, Á., Díaz González, T.E., Pérez Morales, C., Puente García,
E.M., García González, M.E., & Terrón Alfonso, A. 1988.
<span class="nocase">Aportaciones al conocimiento de las comunidades de
malas hierbas de cultivo en la provincia de León</span>. *Acta Botanica
Barcinonensia*

</div>

<div id="ref-RN5504" class="csl-entry">

Pokorná, A., Kočár, P., Novák, J., Šálková, T., Žáčková, P., Komárková,
V., Vaněček, Z., & Sádlo, J. 2018. <span class="nocase">Ancient and
Early Medieval man-made habitats in the Czech Republic: colonization
history and vegetation changes</span>. *Preslia* 90: 171–193.

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

<div id="ref-RN5490" class="csl-entry">

Preston, C.D., Pearman, D.A., & Hall, A.R. 2004.
[<span class="nocase">Archaeophytes in
Britain</span>](https://doi.org/10.1111/j.1095-8339.2004.00284.x).
*Botanical Journal of the Linnean Society* 145: 257–294.

</div>

<div id="ref-RN5499" class="csl-entry">

Pyšek, P. 1998. [<span class="nocase">Alien and native species in
Central European urban floras: a quantitative
comparison</span>](https://doi.org/10.1046/j.1365-2699.1998.251177.x).
*Journal of Biogeography* 25: 155–163.

</div>

<div id="ref-RN5423" class="csl-entry">

Pyšek, P., Chocholousková, Z., Pyšek, A., Jarosík, V., Chytry, M., &
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

<div id="ref-RN5503" class="csl-entry">

Ramos-Gutiérrez, I., Lima, H., Pajarón, S., Romero-Zarco, C., Sáez, L.,
Pataro, L., Molina-Venegas, R., Rodríguez, M.Á., & Moreno-Saiz, J.C.
2021. [<span class="nocase">Atlas of the vascular flora of the Iberian
Peninsula biodiversity hotspot
(AFLIBER)</span>](https://doi.org/10.1111/geb.13363). *Global Ecology
and Biogeography* 30: 1951–1957.

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

Simonova, D., & Lososová, Z. 2008. [<span class="nocase">Which factors
determine plant invasions in man-made habitats in the Czech
Republic?</span>](https://doi.org/10.1016/j.ppees.2007.11.003)
*Perspectives in Plant Ecology, Evolution and Systematics* 10: 89–100.

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
vegetales en parcelas urbanas abandonadas de Asturias</span>. *Trabajo
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

<div id="ref-RN5494" class="csl-entry">

Zohary, M. 1950. [<span class="nocase">The segetal plant communities of
Palestine</span>](http://www.jstor.org/stable/20034504). *Vegetatio* 2:
387–411.

</div>

</div>

# Supplementary Information

**Appendix S1** Checklist of anthropogenic sintaxa that could be present
in the Iberian Atlantic ecoregion according to the literature. Sintaxa
names are provided as recorded by the original authors of the vegetation
plot. The file indicates if the presence of the sintaxon in the Iberian
Atlantic ecoregion was validated or not by our analysis.

**Appendix S2** Original publications providing the vegetation plots
stored in SIVIM and used in our analysis.

**Appendix S3** Characteristic species combinations of the anthropogenic
vegetation alliances in a spreadsheet format, divided into diagnostic,
constant and dominant species.

**Appendix S4** Revised checklist of vegetation associations described
in the regional literature and belonging to the 28 alliances present in
the Iberian Atlantic anthropogenic vegetation.

# Figures

<div class="figure">

<img src="../results/figures/F1 - maps.png" alt="Anthropogenic vegetation alliances of the Iberian Atlantic ecoregion. Each dot is a vegetation plot. Dot colors indicate the vegetation class." width="4251" />
<p class="caption">
<span id="fig:fig1"></span>Figure 1: Anthropogenic vegetation alliances
of the Iberian Atlantic ecoregion. Each dot is a vegetation plot. Dot
colors indicate the vegetation class.
</p>

</div>

<div class="figure">

<img src="../results/figures/F2 - pca.png" alt="Floristic diversity of the anthropogenic plant communities of the Iberian Atlantic ecoregion. Biplots produced by Principal Component Analysis (PCA) with Hellinger transformation. PCAs were conducted for the whole vegetation (A) and for specific subsets (B-F). Colors indicate the vegetation class." width="4251" />
<p class="caption">
<span id="fig:fig2"></span>Figure 2: Floristic diversity of the
anthropogenic plant communities of the Iberian Atlantic ecoregion.
Biplots produced by Principal Component Analysis (PCA) with Hellinger
transformation. PCAs were conducted for the whole vegetation (A) and for
specific subsets (B-F). Colors indicate the vegetation class.
</p>

</div>

<div class="figure">

<img src="../results/figures/F3 - origins.png" alt="Proportion of neophytes, archaeophytes and native species in the anthropogenic plant communities of the Iberian Atlantic ecoregion. Each bar represents the plot-level average proportion of neophytes (dark shade), archaeophytes (medium shade) and natives (light shade) in each vegetation alliance. Colors indicate the vegetation class." width="4251" />
<p class="caption">
<span id="fig:fig3"></span>Figure 3: Proportion of neophytes,
archaeophytes and native species in the anthropogenic plant communities
of the Iberian Atlantic ecoregion. Each bar represents the plot-level
average proportion of neophytes (dark shade), archaeophytes (medium
shade) and natives (light shade) in each vegetation alliance. Colors
indicate the vegetation class.
</p>

</div>

<div class="figure">

<img src="../results/figures/F4 - lifeforms.png" alt="Proportion of therophytes, geophytes and other life forms in the anthropogenic plant communities of the Iberian Atlantic ecoregion. Each bar represents the plot-level average proportion of therophytes (dark shade), geophytes (medium shade) and other life forms (light shade) in each vegetation alliance. Colors indicate the vegetation class." width="4251" />
<p class="caption">
<span id="fig:fig4"></span>Figure 4: Proportion of therophytes,
geophytes and other life forms in the anthropogenic plant communities of
the Iberian Atlantic ecoregion. Each bar represents the plot-level
average proportion of therophytes (dark shade), geophytes (medium shade)
and other life forms (light shade) in each vegetation alliance. Colors
indicate the vegetation class.
</p>

</div>

<div class="figure">

<img src="../results/figures/F5 - height-flowering.png" alt="Vegetation heigh and flowering phenology of the anthropogenic plant communities of the Iberian Atlantic ecoregion. Boxplots show the community-weighted mean for plant heigh, median month of flowering and length of the flowering season for each vegetation alliance. Colors indicate the vegetation class. Alliance numbers are the same as listed in the text." width="4251" />
<p class="caption">
<span id="fig:fig5"></span>Figure 5: Vegetation heigh and flowering
phenology of the anthropogenic plant communities of the Iberian Atlantic
ecoregion. Boxplots show the community-weighted mean for plant heigh,
median month of flowering and length of the flowering season for each
vegetation alliance. Colors indicate the vegetation class. Alliance
numbers are the same as listed in the text.
</p>

</div>

<div class="figure">

<img src="../results/figures/F6 - indicators.png" alt="Ecological requirements of the anthropogenic plant communities of the Iberian Atlantic ecoregion. Boxplots show the plot-level means for the ecological indicator values of temperature, moisture, light, nutrients, soil reaction, disturbance frequency and disturbance severity, calculated for each vegetation alliance. Colors indicate the vegetation class. Alliance numbers are the same as listed in the text." width="4251" />
<p class="caption">
<span id="fig:fig6"></span>Figure 6: Ecological requirements of the
anthropogenic plant communities of the Iberian Atlantic ecoregion.
Boxplots show the plot-level means for the ecological indicator values
of temperature, moisture, light, nutrients, soil reaction, disturbance
frequency and disturbance severity, calculated for each vegetation
alliance. Colors indicate the vegetation class. Alliance numbers are the
same as listed in the text.
</p>

</div>

<div class="figure">

<img src="../results/figures/F7 - pca.png" alt="Ecological requirements of the anthropogenic plant communities of the Iberian Atlantic ecoregion. Biplot produced by Principal Component Analysis (PCA) of the plot-level means for the ecological indicator values of temperature, moisture, light, nutrients, soil reaction, disturbance frequency and disturbance severity. Labels and arrows indicate the contribution of each indicator to the first and second principal components. Colors indicate the vegetation class." width="4228" />
<p class="caption">
<span id="fig:fig7"></span>Figure 7: Ecological requirements of the
anthropogenic plant communities of the Iberian Atlantic ecoregion.
Biplot produced by Principal Component Analysis (PCA) of the plot-level
means for the ecological indicator values of temperature, moisture,
light, nutrients, soil reaction, disturbance frequency and disturbance
severity. Labels and arrows indicate the contribution of each indicator
to the first and second principal components. Colors indicate the
vegetation class.
</p>

</div>
