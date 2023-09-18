## doing two things:

(1) make script to filter unmapped reads (that may have human in them)

cat filterGHA.qs
#!/bin/bash
#SBATCH --partition=week
#SBATCH --time=120:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=S.Hedtke@latrobe.edu.au

module load SAMtools

DIR=/data/group/grantlab/scratch/Ovolvulus_mapped_Ov3/2015_LTU/Ovolvulus_mapped_Ov3_unfiltered_2015LTU_hiseq
gunzip $DIR/*gz
i=OV04
k=GHA_AB1_46_18.sorted.bam
samtools view -bh -F 0x4 $DIR/$i.bam | samtools sort - > $k
i=OV06
k=GHA_AB2_24_12.sorted.bam
samtools view -bh -F 0x4 $DIR/$i.bam | samtools sort - > $k
i=OV07
k=GHA_AB2_24_16.sorted.bam
samtools view -bh -F 0x4 $DIR/$i.bam | samtools sort - > $k
i=OV08
k=GHA_AB2_24_20.sorted.bam
samtools view -bh -F 0x4 $DIR/$i.bam | samtools sort - > $k
i=OV09
k=GHA_AB2_24_21.sorted.bam
samtools view -bh -F 0x4 $DIR/$i.bam | samtools sort - > $k
i=OV23
k=GHA_CHA_34_49.sorted.bam
samtools view -bh -F 0x4 $DIR/$i.bam | samtools sort - > $k
i=OV26
k=GHA_JAG_33_35.sorted.bam
samtools view -bh -F 0x4 $DIR/$i.bam | samtools sort - > $k
i=OV30
k=GHA_JAG_81_24.sorted.bam
samtools view -bh -F 0x4 $DIR/$i.bam | samtools sort - > $k
i=OV31
k=GHA_JAG_83_26.sorted.bam
samtools view -bh -F 0x4 $DIR/$i.bam | samtools sort - > $k
i=OV33
k=GHA_KOJ_190_20.sorted.bam
samtools view -bh -F 0x4 $DIR/$i.bam | samtools sort - > $k
i=OV37
k=GHA_KOJ_75_16.sorted.bam
samtools view -bh -F 0x4 $DIR/$i.bam | samtools sort - > $k
i=OV38
k=GHA_KYG_44_15.sorted.bam
samtools view -bh -F 0x4 $DIR/$i.bam | samtools sort - > $k
i=OV39
k=GHA_KYG_70_21.sorted.bam
samtools view -bh -F 0x4 $DIR/$i.bam | samtools sort - > $k
i=OV57
k=GHA_ASU_7_15.sorted.bam
samtools view -bh -F 0x4 $DIR/$i.bam | samtools sort - > $k

DIR=/data/group/grantlab/scratch/Ovolvulus_mapped_Ov3/2015_TGI/Ovolvulus_mapped_Ov3_unfiltered_2015TGI_hiseq
gunzip $DIR/*bam.gz
i=OV58
k=GHA_AB1_46_20.sorted.bam
samtools view -bh -F 0x4 $DIR/$i.bwa.sorted.bam > $k
i=OV62
k=GHA_JAG_61_11.sorted.bam
samtools view -bh -F 0x4 $DIR/$i.bwa.sorted.bam > $k
i=OV65
k=GHA_JAG_54_10.sorted.bam
samtools view -bh -F 0x4 $DIR/$i.bwa.sorted.bam > $k
i=OV67
k=GHA_KYG_4_2.sorted.bam
samtools view -bh -F 0x4 $DIR/$i.bwa.sorted.bam > $k
i=OV68
k=GHA_KYG_29_11.sorted.bam
samtools view -bh -F 0x4 $DIR/$i.bwa.sorted.bam > $k
i=OV70
k=GHA_KYG_4_1.sorted.bam
samtools view -bh -F 0x4 $DIR/$i.bwa.sorted.bam > $k
i=OV72
k=GHA_NLG_86_14.sorted.bam
samtools view -bh -F 0x4 $DIR/$i.bwa.sorted.bam > $k
i=OV73
k=GHA_NLG_24_4.sorted.bam
samtools view -bh -F 0x4 $DIR/$i.bwa.sorted.bam > $k
i=OV78
k=GHA_CHA_54_31.sorted.bam
samtools view -bh -F 0x4 $DIR/$i.bwa.sorted.bam > $k

## for Cameroon, the unique files are /data/group/grantlab/project/data/Ovolvulus/allegro/mapped/Ovolvulus_unique_v3_2018Allegro/

but the /data/group/grantlab/project/data/Ovolvulus/allegro/mapped/Ovolvulus_unfiltered_mapped_v3_2018Allegro/

is incomplete. It is not in the scratch directory and not waiting to be archived. See if it's on any of your backup drives.