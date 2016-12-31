## Prokaryotic annotation

An annotation pipeline for bacterial genomes

### Quick Start

To execute the pipeline on your computer, first pull the docker image

    docker pull hadrieng/prokka

Then execute the workflow

    nextflow run annotation.nf --genome $path_to_your_genome

It will produce an embl file ready for submission (given you have registered a
bioproject and locus tag) as well as .gbk, .gff and other files from the output
of prokka

### Pipeline Parameters

#### --genome

* Specifies the location of the genome fasta file
* Required

#### --bioproject

* The Bioproject you registered at ENA
* If not set, will be PRJEBXXXXX

#### --genus

* The genus of the genome to annotate

#### --species

* the species of the genome to annotate

#### --strain

* the strain of the genome to annotate

#### --locus_tag

* The desired locus tag. Should also be registered at ENA
* If not set, it will be XXX

#### --taxonomy

* the taxid of your organism

### Profiles

*The SGBC cluster uses a module system. Pulling the docker image is not required!*

By default, the pipeline runs locally using docker. If you run the annotation
pipeline on the SGBC cluster, please pass the option **-profile planet**

Example:

    netxflow run annotation.nf -profile planet --genome data/aureus.fasta \
    --bioproject PRJEB12345 --genus Staphylococcus --species aureus \
    --strain ST250_MRSA-1 --locus_tag SA0 --taxonomy 1280

### Citations

If you use this pipeline in your research, please cite:

> * Circlator: automated circularization of genome assemblies using long sequencing reads, Hunt et al, Genome Biology 2015 Dec 29;16(1):294. doi: 10.1186/s13059-015-0849-0. PMID: 26714481.
> * Seemann T. Prokka: rapid prokaryotic genome annotation, Bioinformatics 2014 Jul 15;30(14):2068-9. PMID:24642063
> * GFF3toEMBL: Preparing annotated assemblies for submission to EMBL", Andrew J. Page, Sascha Steinbiss, Ben Taylor, Torsten Seemann, Jacqueline A. Keane, The Journal of Open Source Software, 1 (6) 2016. http://dx.doi.org/10.21105/joss.00080
