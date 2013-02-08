# Here Read This

## Documentation for Index Page

### `<HEAD />` Header 
* Remember that Character encoding must appear within first 512 bytes of page:
  [http://www.w3.org/TR/xhtml-rdfa-primer/#using-multiple-vocabularies](http://www.w3.org/TR/xhtml-rdfa-primer/#using-multiple-vocabularies)
* HTML5 does not support `<html version="HTML+RDFa 1.1">`
* **RDFa** is "Resource Description Framework in attributes," which is a way to apply metadata and semantics to a page.
    * Primers:
        * **[W3 RDFa for HTML Authors](http://www.w3.org/MarkUp/2009/rdfa-for-html-authors)**
        * **[W3 RDFa Primer](http://www.w3.org/TR/xhtml-rdfa-primer/)**
        * **[W3 RDFa in HTML](http://www.w3.org/TR/rdfa-in-html/)**
        * [3kbo RDFa working example](http://blog.3kbo.com/2010/11/10/simple-html5-rdfa-example/)
        * [3kbo Wiki for RDFa](http://notes.3kbo.com/rdfa)
        * [Manu Sporny's RDFa Lite for Dummies](http://manu.sporny.org/2011/rdfa-lite/)
        * [W3 Web Ontoloty Language (OWL) Primer](http://www.w3.org/TR/owl2-primer/)
        * [Semantic Web Blog](http://semanticweb.com/)
    * **Prefixes:**
        * The property `dc:title` represents "http://purl.org/dc/terms/title"
        * `dc:title` is called a Compact URL, aka CURIE, which is a representation of a URI from html prefix `prefix="dc: http://purl.org/dc/terms/"`

            ```html
            <section prefix="dc:http://purl.org/dc/terms/title" typeof="dc:BibliographicResource" resource="/anna_karenina/">
                <h1 property="dc:title">Anna Karenina</h1>
                <p property="dc:creator">Leo Tolstoy</p>
                <time property="dc:created">1878</time>
            </section>
            ```
            That is, if running a query against the RDFa, the resource `/anna_karenina/` has the title, "Anna Karenina", which was created by Leo Tolsty in 1878.
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
        * [Bibliographic reference](http://uri.gbv.de/ontology/bibo/)
    * **Useful RDFa Tools and Apps:**
        * [Debug RDFa in HTML with mappings](http://rdfa.info/play/)
        * **[Watch RDFa visualization using dbpedia](http://www.visualdataweb.org/relfinder/relfinder.php)**
        * [W3 Established Good Ontologies](http://www.w3.org/wiki/Good_Ontologies)
        * [Test with Google Rich Snippets](http://www.google.com/webmasters/tools/richsnippets)
        * [W3 pyRDFa XML/JSON extraction](http://www.w3.org/2012/pyRdfa/)
        * [W3 RDFa Validation Tool](http://www.w3.org/RDF/Validator/)
        * [Convert RDF XML to TURTLE](http://www.rdfabout.com/demo/validator/index.xpd)
    * **Open Graph RDFa and Facebook**
        * Facebook JSON via Graph, e.g., [https://graph.facebook.com/142652672557253](https://graph.facebook.com/142652672557253)
        * Linter is at [https://developers.facebook.com/tools/debug](https://developers.facebook.com/tools/debug)
        * [Documentation on Open Graph `prefix="og"` protocol](https://developers.facebook.com/docs/opengraphprotocol/)
        * curl `https://developers.facebook.com/tools/lint/?url=http%3A%2F%2Fherereadthis.com&format=json`
    * **FOAF (Friend of a Friend)** is a vocabulary for identifying people and their relationships to their works and other people.
        * [Starter: Foaf-O-Matic FOAF File generation](http://www.ldodds.com/foaf/foaf-a-matic.en.html)
        * [FOAF Project Wiki](http://wiki.foaf-project.org/w/FAQ) 
        * [FOAF XML Specification](http://xmlns.com/foaf/spec/)
        * Examples of Good FOAF files from leaders: [Ivan Herman](http://www.ivan-herman.net/foaf.rdf) and [Henry Story](http://bblfish.net/people/henry/card#me)
        * [Explore FOAF Connections](http://xml.mfd-consult.dk/foaf/)
        * [Use FOAF to generate WebID (primer)](http://trueg.wordpress.com/2012/03/15/webid-a-guide-for-the-clueless/)
        * [WebID Wiki](http://www.w3.org/wiki/WebID http://webid.info/)
        * [Generate WebID Certificate and RSA Public Key](https://my-profile.eu/certgen.php)
        * Test and confirm certificate is working: [foaf SSL](https://foafssl.org/test/WebId) or [My Profile](https://my-profile.eu/)
* **Icons**
    * [Online favicon generation (.ICO format)](http://convertico.com)
    * [Icons for iOS (iPhone and iPad) at Apple Developers](http://developer.apple.com/library/ios/#documentation/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html)


### Ezra Pound, *Personae*
Dear, an this dream come true,/
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




