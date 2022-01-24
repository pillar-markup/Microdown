Class {
	#name : #MicH5PTemplateWriterTest,
	#superclass : #TestCase,
	#category : #'Microdown-H5P'
}

{ #category : #tests }
MicH5PTemplateWriterTest >> presentationInMicrodown [

^ '
{
    "title":"About Validation",
    "subtitle":"A pretext to talk about optional actions",
    "author":"Tintin and Mickey"
}
', 
self twoSlidesInMicrodown 
]

{ #category : #tests }
MicH5PTemplateWriterTest >> slideInMicrodown [

^ '
<?slide|title=A nice title isn''t&tag=nh5p

- slide 1 bullet 1
- slide 1 bullet 2
- slide 1 bullet 3
?>



'
]

{ #category : #tests }
MicH5PTemplateWriterTest >> testNSlide [

	| doc h5p |
	doc := Microdown parse: self twoSlidesInMicrodown.
	h5p := MicH5PTemplateWriter new.
	h5p fillUpSlides: doc children.
	self assert: h5p contents equals: '{
            "elements":[
               {
                  "x":6.5359477124183005,
                  "y":19.365916847056596,
                  "width":88.037037037037,
                  "height":73.160071277275,
                  "action":{
                     "library":"H5P.AdvancedText 1.1",
                     "params":{
                        "text":"<ul>\n\t<li><span style=\"font-size:1.125em\">slide 1 bullet 1</span></li>\n\t<li><span style=\"font-size:1.125em\">slide 1 bullet 2</span></li>\n\t<li><span style=\"font-size:1.125em\">slide 1 bullet 3</span></li>\n\t\n</ul>\n"
                     },
                     "metadata":{
                        "contentType":"Text",
                        "license":"U",
                        "title":"Untitled Text",
                        "authors":[ ],
                        "changes":[ ]
                     }
                  },
                  "alwaysDisplayComments":false,
                  "backgroundOpacity":0,
                  "displayAsButton":false,
                  "buttonSize":"big",
                  "goToSlideType":"specified",
                  "invisible":false,
                  "solution":""
               },
               {
                  "x":2.178649237472767,
                  "y":2.151768538561844,
                  "width":95.86056644880175,
                  "height":17.214148308494753,
                  "action":{
                     "library":"H5P.AdvancedText 1.1",
                     "params":{
                        "text":"<h2>A nice title isn''t</h2>\n" 
                      },
                     "metadata":{
                        "contentType":"Text",
                        "license":"U",
                        "title":"Untitled Text",
                        "authors":[ ],
                        "changes":[ ]
                     }
                  },
                  "alwaysDisplayComments":false,
                  "backgroundOpacity":0,
                  "displayAsButton":false,
                  "buttonSize":"big",
                  "goToSlideType":"specified",
                  "invisible":false,
                  "solution":""
               }
            ],
            "slideBackgroundSelector":{ },
            "keywords":[
               {
                  "main":"A nice title isn''t"
               }
            ]
         },
{
            "elements":[
               {
                  "x":6.5359477124183005,
                  "y":19.365916847056596,
                  "width":88.037037037037,
                  "height":73.160071277275,
                  "action":{
                     "library":"H5P.AdvancedText 1.1",
                     "params":{
                        "text":"<ul>\n\t<li><span style=\"font-size:1.125em\">slide 2 bullet 1</span></li>\n\t<li><span style=\"font-size:1.125em\">bullet 2</span></li>\n\t<li><span style=\"font-size:1.125em\">bullet 2</span></li>\n\t\n</ul>\n"
                     },
                     "metadata":{
                        "contentType":"Text",
                        "license":"U",
                        "title":"Untitled Text",
                        "authors":[ ],
                        "changes":[ ]
                     }
                  },
                  "alwaysDisplayComments":false,
                  "backgroundOpacity":0,
                  "displayAsButton":false,
                  "buttonSize":"big",
                  "goToSlideType":"specified",
                  "invisible":false,
                  "solution":""
               },
               {
                  "x":2.178649237472767,
                  "y":2.151768538561844,
                  "width":95.86056644880175,
                  "height":17.214148308494753,
                  "action":{
                     "library":"H5P.AdvancedText 1.1",
                     "params":{
                        "text":"<h2>Slide3 blah</h2>\n" 
                      },
                     "metadata":{
                        "contentType":"Text",
                        "license":"U",
                        "title":"Untitled Text",
                        "authors":[ ],
                        "changes":[ ]
                     }
                  },
                  "alwaysDisplayComments":false,
                  "backgroundOpacity":0,
                  "displayAsButton":false,
                  "buttonSize":"big",
                  "goToSlideType":"specified",
                  "invisible":false,
                  "solution":""
               }
            ],
            "slideBackgroundSelector":{ },
            "keywords":[
               {
                  "main":"Slide3 blah"
               }
            ]
         }' 
]

{ #category : #tests }
MicH5PTemplateWriterTest >> testOneSlide [

	| doc h5p |
	doc := Microdown parse: self slideInMicrodown.
	h5p := MicH5PTemplateWriter new fillUpOneSlide: doc children first.
	self assert: h5p equals: '{
            "elements":[
               {
                  "x":6.5359477124183005,
                  "y":19.365916847056596,
                  "width":88.037037037037,
                  "height":73.160071277275,
                  "action":{
                     "library":"H5P.AdvancedText 1.1",
                     "params":{
                        "text":"<ul>\n\t<li><span style=\"font-size:1.125em\">slide 1 bullet 1</span></li>\n\t<li><span style=\"font-size:1.125em\">slide 1 bullet 2</span></li>\n\t<li><span style=\"font-size:1.125em\">slide 1 bullet 3</span></li>\n\t\n</ul>\n"
                     },
                     "metadata":{
                        "contentType":"Text",
                        "license":"U",
                        "title":"Untitled Text",
                        "authors":[ ],
                        "changes":[ ]
                     }
                  },
                  "alwaysDisplayComments":false,
                  "backgroundOpacity":0,
                  "displayAsButton":false,
                  "buttonSize":"big",
                  "goToSlideType":"specified",
                  "invisible":false,
                  "solution":""
               },
               {
                  "x":2.178649237472767,
                  "y":2.151768538561844,
                  "width":95.86056644880175,
                  "height":17.214148308494753,
                  "action":{
                     "library":"H5P.AdvancedText 1.1",
                     "params":{
                        "text":"<h2>A nice title isn''t</h2>\n" 
                      },
                     "metadata":{
                        "contentType":"Text",
                        "license":"U",
                        "title":"Untitled Text",
                        "authors":[ ],
                        "changes":[ ]
                     }
                  },
                  "alwaysDisplayComments":false,
                  "backgroundOpacity":0,
                  "displayAsButton":false,
                  "buttonSize":"big",
                  "goToSlideType":"specified",
                  "invisible":false,
                  "solution":""
               }
            ],
            "slideBackgroundSelector":{ },
            "keywords":[
               {
                  "main":"A nice title isn''t"
               }
            ]
         }' 
]

{ #category : #'low level visitor tests' }
MicH5PTemplateWriterTest >> testOneSlideBodyWithBullets [

	| doc h5p |
	doc := Microdown parse: self slideInMicrodown.
	h5p := MicH5PTemplateWriter new.
	h5p visit: doc children first.
	self assert: h5p contents equals: '<ul>\n\t<li><span style=\"font-size:1.125em\">slide 1 bullet 1</span></li>\n\t<li><span style=\"font-size:1.125em\">slide 1 bullet 2</span></li>\n\t<li><span style=\"font-size:1.125em\">slide 1 bullet 3</span></li>\n\t\n</ul>\n' 
]

{ #category : #tests }
MicH5PTemplateWriterTest >> testSlides [

	| doc |
	doc := Microdown parse: 

'
{
    "title":"About Validation",
    "subtitle":"A pretext to talk about optional actions",
    "author":""
}

<?slide|title=Slide2 Bli&tag=nh5p

- slide 2 bullet 1
- slide 2 bullet 2
- slide 2 bullet 3
?>.

<?slide|title=Slide3 blah&tag=nh5p

- slide 3 bullet 1
- bullet 2
- bullet 3
?>'
]

{ #category : #tests }
MicH5PTemplateWriterTest >> twoSlidesInMicrodown [

^ self slideInMicrodown, '

<?slide|title=Slide3 blah&tag=nh5p

- slide 2 bullet 1
- bullet 2
- bullet 2
?>'
]
