# Here Read This
(Incomplete) [extended documentation](https://github.com/herereadthis/herereadthis/blob/master/docs/readme.md) is located in `docs` directory.

## Documentation for Index Page

### `<HEAD />` Header 
* Remember that Character encoding must appear within first 512 bytes of page:
  [http://www.w3.org/TR/xhtml-rdfa-primer/#using-multiple-vocabularies](http://www.w3.org/TR/xhtml-rdfa-primer/#using-multiple-vocabularies)
* HTML5 does not support `<html version="HTML+RDFa 1.1">`
* **RDFa** is "Resource Description Framework in attributes," which is a way to apply metadata and semantics to a page.
    * **Primers** (at least read the first 4 links):
        * W3 References: **[W3 RDFa for HTML Authors](http://www.w3.org/MarkUp/2009/rdfa-for-html-authors)**, **[W3 RDFa Primer](http://www.w3.org/TR/xhtml-rdfa-primer/)**, **[W3 RDFa in HTML](http://www.w3.org/TR/rdfa-in-html/)**
        * [3kbo RDFa working example](http://blog.3kbo.com/2010/11/10/simple-html5-rdfa-example/) and [3kbo Wiki for RDFa](http://notes.3kbo.com/rdfa)
        * [Manu Sporny's RDFa Lite for Dummies](http://manu.sporny.org/2011/rdfa-lite/)
        * [Google Rich Snippets for People](http://support.google.com/webmasters/bin/answer.py?hl=en&answer=146646)
    * **Prefixes:**
        * The property `dc:title` is defined by `http://purl.org/dc/terms/title` Therefore, `dc:title` is called a Compact URL, aka CURIE, which is a representation of a URI from html prefix `prefix="dc: http://purl.org/dc/terms/"`

            ```html
            <section prefix="dc:http://purl.org/dc/terms/title" typeof="dc:BibliographicResource" resource="/anna_karenina/">
                <h1 property="dc:title">Anna Karenina</h1>
                <p property="dc:creator">Leo Tolstoy</p>
                <time property="dc:created">1878</time>
            </section>
            ```
            That is, if running a query against the RDFa, the resource `/anna_karenina/` has the title, "Anna Karenina", which was created by Leo Tolsty in 1878.

            ```xml
            @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
            @prefix dc: <http://purl.org/dc/terms/> .
            <http://example.com/anna_karenina/>
               rdf:type dc:BibliographicResource;
               dc:title "Anna Karenina";
               dc:creator "Leo Tolstoy";
               dc:created "1878" .
            ```
        * Prefixes can be added anywhere; the higher up the DOM tree, the more areas to which it applies.
        * All prefixes on this site, either in HTML or body:

            ```html
            Creative Commmons:      cc="http://creativecommons.org/ns#"
            Dublin Core Terms:      dc="http://purl.org/dc/terms/"
            DCMI Types:             dcmitype="http://purl.org/dc/dcmitype/"
            Geo Spatial:            geo="http://www.w3.org/2003/01/geo/wgs84_pos#"
            Facebook:               fb="http://ogp.me/ns/fb#"
            Friend of a Friend:     foaf="http://xmlns.com/foaf/0.1/"
            Open Graph:             og="http://ogp.me/ns#"
            Open Graph music:       og="http://ogp.me/ns/music#"
            Vcard:                  v="http://rdf.data-vocabulary.org/#"
            Bibliographic:          bibo="http://purl.org/ontology/bibo/" 
            W3 Ontology Language:   owl: http://www.w3.org/2002/07/owl#
            XML:                    xsd: http://www.w3.org/2001/XMLSchema#
            ```
            * [Bibliographic Ontology reference](http://uri.gbv.de/ontology/bibo/)
            * [W3 Web Ontoloty Language (OWL) Primer](http://www.w3.org/TR/owl2-primer/)
            * [Dublin Core Metadata Initiative](http://dublincore.org/)
            * [W3 VCard](http://www.w3.org/Submission/vcard-rdf/)
    * **Useful RDFa Tools and Apps:**
        * [Debug RDFa in HTML with mappings](http://rdfa.info/play/)
        * **[Watch RDFa visualization using dbpedia](http://www.visualdataweb.org/relfinder/relfinder.php)**
        * [W3 Established Good Ontologies](http://www.w3.org/wiki/Good_Ontologies)
        * [Test with Google Rich Snippets](http://www.google.com/webmasters/tools/richsnippets)
        * [W3 pyRDFa XML/JSON extraction](http://www.w3.org/2012/pyRdfa/)
        * [W3 RDFa Validation Tool](http://www.w3.org/RDF/Validator/)
        * [Convert RDF XML to TURTLE](http://www.rdfabout.com/demo/validator/index.xpd)
        * [Semantic Web Blog](http://semanticweb.com/)
    * **Open Graph RDFa and Facebook**
        * Facebook JSON via Graph, e.g., [https://graph.facebook.com/142652672557253](https://graph.facebook.com/142652672557253)
        * Linter is at [https://developers.facebook.com/tools/debug](https://developers.facebook.com/tools/debug)
        * [Documentation on Open Graph `prefix="og"` protocol](https://developers.facebook.com/docs/opengraphprotocol/)
        * curl `https://developers.facebook.com/tools/lint/?url=http%3A%2F%2Fherereadthis.com&format=json`
    * **FOAF (Friend of a Friend)** is a vocabulary for identifying people and their relationships to their works and other people. [Go to FOAF + WebID Docs](/herereadthis/herereadthis/blob/master/docs/foaf.md)
* **Icons**
    * [Online favicon generation (.ICO format)](http://convertico.com)
    * [Icons for iOS (iPhone and iPad) at Apple Developers](http://developer.apple.com/library/ios/#documentation/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html)

### `<header role="banner" />` Header
* `role="banner"` is a WAI-ARIA Landmark Role. See the [documentation](/herereadthis/herereadthis/blob/master/docs/wai_aria.md) )

### `<article id="photos" />` Photography Article

### `<article id="coding" />` Coding Article
* Resources on HTML5 Sectioning Outline
    * [Geoffrey Sneddon's HTM5 Outliner tool](http://gsnedders.html5.org/outliner/process.py?url=http%3A%2F%2Fherereadthis.com%2F)
    * [HTML5 sectioning elements, headings, and document outlines](http://www.456bereastreet.com/archive/201103/html5_sectioning_elements_headings_and_document_outlines/)
    * [HTML5 document outline revisited](http://www.456bereastreet.com/archive/201104/html5_document_outline_revisited/)
    * [HTML5 Doctor Sectioning Flowchart (.PDF)](http://html5doctor.com/downloads/h5d-sectioning-flowchart.pdf)
* [CoffeeScript Documentation](http://coffeescript.org/)

### `<article id="design_modern" />` Design Article

* Complete Quote For Nagy (Swiped from [Daily Icon](swiped from http://www.dailyicon.net/2009/12/books-vision-in-motion-by-laszlo-moholy-nagy/))
    * Design has many connotations. It is the organization of materials and processes in the most productive, economic way, in a harmonious balance of all elements necessary for a certain function. It is not a matter of façade, of mere external appearance rather it is the essence of products and institutions, penetrating and comprehensive. Designing is a complex and intricate task. It is integration of technological, social and economic requirements, biological necessities, and the psychophysical effects of materials, shape, color, volume, and space: thinking in relationships. The designer must see the periphery as well as the core, the immediate and the ultimate, at least in the biological sense. He must anchor his special job in the complex whole. The designer must be trained not only in the use of materials and various skills, but also in appreciation of organic functions and planning. He must know that design is indivisible, that the internal and external characteristics of a dish, a chair, a table, a machine, painting, sculpture are not to be separated. The idea of design and the profession of the designer has to be transformed from the notion of a specialist function into a generally valid attitude of resourcefulness and inventiveness which allows projects to be seen not in isolation but in relationship with the need of the individual and the community. One cannot simply lift out any subject matter from the complexity of life and try to handle it as an independent unit.
* Inspirations
    * Herbert Spencer, [*Pioneers of Modern Typography*](http://en.wikipedia.org/wiki/Pioneers_of_Modern_Typography)
* Ezra Pound, *Personae*
    * Dear, an this dream come true,/
I, who being poet only,/
Can give thee poor words only,/
Add this one poor other tribute,/
***This thing men call immortality.***/
A gift I give thee even as Ronsard gave it./
Seeing before time, one sweet face grown old,/
And seeing the old eyes grow bright/
From out the border of Her fire-lit wrinkles,/
As she should make boast unto her maids/
&ldquo;Ronsard hath sung the beauty, my beauty,/
Of the days that I was fair.&rdquo;




