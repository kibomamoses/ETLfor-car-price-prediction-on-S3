#!/bin/bash
#chmod u+x S3_write.command

echo "S3 Bucket Contents"
echo "---------------------------------"

aws s3 ls s3://kiboma/cardata

echo "---------------------------------"


#Extract Stage

if [ "$1" = "write_extract" ]; then
echo "---------------------------------"
echo "Writing files to S3 Bucket..."
aws s3 sync cardata_extraction.parquet s3://kiboma/cardata/extract --delete
echo "Write complete."
echo "---------------------------------"
fi

#aws s3 cp command does not remove non-overlapping parquet files from previous read


if [ "$1" = "read_extract" ]; then
echo "---------------------------------"
echo "Reading files from S3 Bucket..."
aws s3 sync s3://kiboma/cardata/extract cardata_extrct_dowload.parquet --delete
echo "Read complete."
echo "---------------------------------"
fi


#Transform Stage

if [ "$1" = "write_transform" ]; then
echo "---------------------------------"
echo "Writing files to S3 Bucket..."
aws s3 sync clean_carsdata_transform.parquet s3://kiboma/cardata/transform --delete
echo "Write complete."
echo "---------------------------------"
fi

#aws s3 cp command does not remove non-overlapping parquet files from previous read


if [ "$1" = "read_transform" ]; then
echo "---------------------------------"
echo "Reading files from S3 Bucket..."
aws s3 sync s3://kiboma/cardata/transform cardata_transform.parquet --delete
echo "Read complete."
echo "---------------------------------"
fi






echo "---------------------------------"

#end
