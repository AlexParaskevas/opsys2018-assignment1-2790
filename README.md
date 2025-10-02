An assignment on bash scripting within the course of Operation Systems of CSD AUTH.

**Script1A** a website change tracker. Checks a list of URLs from a text file and for each URL, downloads the page if it's encountered for the first time. If it already exists, it compares the old vs the new content and if it has changed it updates the saved copy and logs the url in a text file.

**Script1B** the same 'website change tracker' idea but it introduces urlcheck(), a function which chacks if a URL is seen for the first time it's fetched in the backround, allowing multiple new URLs to be downloaded at once.

**Script 2** A bulk repo fetcher & validator. Takes a .tar.gz file as input, unpacks a list of Git repos, clones them and checks if each repository contains a required structure (dataA.txt, more/, dataB.txt, dataC.txt).
