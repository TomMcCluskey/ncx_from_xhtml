ncx_from_xhtml
==============

Ruby script that takes an epub 3.0 toc.xhtml as input and produces a toc.ncx

It's pretty bare bones, but can be handy for getting the bulk of the content done. It uses the nokogiri gem for xml parsing.

Usage: It will grab a file in its current directory named toc.xhtml and produce a toc.ncx file based on it.
