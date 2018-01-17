IMPORT 'file:///ml4omics/udf/Module1.class' AS module;


gdsc_glioma = LOAD 'file:///ml4omics/module0/module0_0'
                    AS (
                        'cell_line_name',
                        'cosmic_id',
                        'histology',
                        'tissue',
                        'drug_name',
                        'drug_id',
                        'ln_ic50',
                        'auc',
                        'ic_50_uM'
                    )
                    KEY('cosmic_id');


drugs_name = LOAD 'file:///ml4omics/module1/CosmicCLP_MutantExport.ts' AS () DELIMITER '\t';

drugs_name_map = MAP drugs_name -> module.firstMap();

gdsc_glioma_uni = DISTINCT gdsc_glioma;

gdsc_glioma_mut = JOIN drugs_name_map -> {drugs_name_map.id_sample}, gdsc_glioma_uni -> {gdsc_glioma_uni.cosmic_id};

gdsc_glioma_map = MAP gdsc_glioma_mut -> module.secondMap();

gdsc_glioma_gro = GROUP_BY gdsc_glioma_map -> { gdsc_glioma_map.gene_name };

frecuency = MAP gdsc_glioma_gro -> module.getFrecuency();

frecuency_sort = SORT frecuency;

top_k = LIMIT frecuency_sort, 1000;

gene_list = MAP top_k -> module.getGene_name();

STORE gene_list 'file:///ml4omics/module1/output1_1.csv';

/** DCAST START */
gdsc_glioma_short = FLATMAP top_k -> module.flatMap();

gdsc_glioma_short_grp = GROUP_BY gdsc_glioma_short -> module.getKeyGlioma();

gdsc_glioma_short_uni = DISTINCT gdsc_glioma_short;

gdsc_glioma_short_dcast = MAP gdsc_glioma_short_grp -> module.dcast WITH BROADCAST gdsc_glioma_short_uni;

/** DCAST END*/

STORE gdsc_glioma_short_dcast 'file:///ml4omics/module1/output1_2.csv';

