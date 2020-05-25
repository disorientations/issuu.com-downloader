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
docker run -it --rm -v $(pwd):/app issuu-downloader
```

## Dependencies

Use [Bundler](https://bundler.io/) to install project dependencies on your local system.

```sh
bundle install
```
