#!/usr/bin/env nextflow

params.genome = ''
params.bioproject = 'PRJEBXXXXX'
params.species = 'species'
params.genus = 'genus'
params.strain = 'strain'
params.locus_tag = 'XXX'
params.taxonomy = 1

genome = file(params.genome)
species = params.species
genus = params.genus
strain = params.strain
locus_tag = params.locus_tag
taxonomy = params.taxonomy
bioproject = params.bioproject

process circlator {
    input:
        file input from genome

    output:
        file 'genome.fasta' into circular_genome

    """
    circlator fixstart $input genome
    """
}

process prokka {
    publishDir bioproject

    input:
        file input from circular_genome
        val locus from locus_tag
        val bioproject from bioproject
        val species from species
        val genus from genus
        val strain from strain

    output:
        file "${bioproject}/${locus_tag}.gff" into annotation_gff
        file "${bioproject}/${locus_tag}*" into annotation

    """
    prokka --compliant --centre SLU --outdir $bioproject \
        --locustag $locus_tag --prefix $locus_tag --kingdom Bacteria \
        --genus $genus --species $species --strain $strain --usegenus \
        $input
    """
}

process gff3toembl {
    publishDir bioproject

    input:
        val bioproject from bioproject
        val species from species
        val genus from genus
        val strain from strain
        val taxonomy from taxonomy
        file input from annotation_gff

    output:
        file "${locus_tag}.embl.gz" into embl_file

    """
        gff3_to_embl --genome_type 'circular' --classification 'prokka' \
        --output_filename ${locus_tag}.embl --translation_table 11 \
        "$genus $species" $taxonomy $bioproject "$genus $species $strain" \
        $input
        gzip ${locus_tag}.embl
    """
}
