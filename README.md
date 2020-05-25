# issuu.com Downloader

Downloads publications from issuu.com when the download option has been disabled for the hosted document. The resulting PDF could be OCR'ed in another step using [pdfocr](https://github.com/gkovacs/pdfocr/) or similar.

In practice the script does not actually download the PDF, but rather downloads the images of the pages of the flash object, and then combines those into a PDF.

[Details of construction](http://pietropassarelli.com/issuu.html)

## Docker

This project can be run within [Docker](https://www.docker.com/).

```sh
# Build the image
docker build -t issuu-downloader .

# Run the image
docker run --rm -v $(pwd):/app issuu-downloader document_id "magazine_name"
```

## Downloading Multiple Documents

Using the above Docker command to run the image, you can script downloading multiple documents.

Let's say you have a comma-delimited file called `files.txt` with the magazine
name and document ID on each line. Here's an example.

```
Dis-Orientation Guide 1996-1997,140529092453-b45ba390815f0b4848c24f7b0b219164
Agitation Education,130904154632-77ac842ae19549c4f1aa5f3b568f274b
Bartlett Book 2015,151209133912-2f43550b00644da53ed0bf78addcd4a5
Of Discourse and Disorientation (10.1.2014),181030203524-2a106e2dd6ee0d3c0fa4d68521d7fccd
Disorientation 2012,120905184953-631bb6c4498d42c58ce3e78cbb5d3532
Disorientation 2011,110907083445-fa09caa3ed9c437789fe649a3b9f49bf
Student Disorientation Handbook,131212213243-2cc89a2c04a67efd7080778a961e7dce
2012 Disorientation Guide,121205112123-49ecec06d96f4fd890365e6950527125
Tufts Disorientation Guide 2017,170829225309-1600973e4e85b3893a12789b07dec304
UChicago DisOrientation Book 2016,160926051445-284aca72436113030cfc7c58a8c9f6b8
UChicago DisOrientation 2010,160822233246-d5144a88673450fa1678755828a08bb9
UChicago DisOrientation 2013,160822233501-96b17f9be09b5c3378d55302a28f69ff
UChicago DisOrientation 2011,160905213842-47c3eab70188fb628362598613177b0e
DisOrientation Book 2019,191217044004-692d12b23b83eead3380d40c026d4b1d
DisOrientation Book 2018,180924013743-85dec77e41b59030ad75c4bc2e2bd80f
UVA Disorientation Guide: The Pursuit Of Truth Begins Here,170902175606-4ef72f0c4e5bfca8159104b39b3b8202
Vassar Disorientation Guide 2019-2020,190831040154-93c7e9362ee0f128f8c6e5b9edc2838c
```

You can invoke the following code in a bash shell to download each of these documents.

```sh
while IFS=, read magazine_name document_id; do
    docker run --rm -v $(pwd):/app issuu-downloader $document_id "$magazine_name"
done < files.txt
```

## Dependencies

Use [Bundler](https://bundler.io/) to install project dependencies on your local system.

```sh
bundle install
```
