Class {
	#name : #MicH5PTemplateWriterTest,
	#superclass : #TestCase,
	#category : #'Microdown-H5P'
}

{ #category : #sample }
MicH5PTemplateWriterTest >> mainSlideInMicrodown [

^ '
{
    "title":"About Validation",
    "subtitle":"A pretext to talk about optional actions",
    "author":"Tintin and Mickey"
}

'
]

{ #category : #sample }
MicH5PTemplateWriterTest >> oneSlideWithCodeInMicrodown [

^ '

<!slide|title=Nice code eh!&tag=nh5p

```
SpTextInputFieldWithValidation >> validateInto: aValidationReport
	self validate.
	aValidationReport addAll: validationErrors
```


!>'
]

{ #category : #sample }
MicH5PTemplateWriterTest >> presentationInMicrodown [

^ self mainSlideInMicrodown , self twoSlidesInMicrodown 
]

{ #category : #sample }
MicH5PTemplateWriterTest >> slideInMicrodown [

^ '
<!slide|title=A nice title isn''t&tag=nh5p

- slide 1 bullet 1
- slide 1 bullet 2
- slide 1 bullet 3
!>



'
]

{ #category : #sample }
MicH5PTemplateWriterTest >> slideInMicrodownWithCode [

^ '
<!slide|title=A piece of code&tag=nh5p

```
testMethod
	self assert: 4 foo equals: 55
```

```
testFoo
   self assertSpace.
   self assertSpace2
   ^ self
```
!>



'
]

{ #category : #sample }
MicH5PTemplateWriterTest >> slideInMicrodownWithSimpleCode [

^ '
<!slide|title=A piece of code&tag=nh5p

```
testMethod
	self assert: 4 foo equals: 55
```
!>



'
]

{ #category : #sample }
MicH5PTemplateWriterTest >> slideWithFigure [

^ '
<!slide|title=A nice title isn''t&tag=nh5p


![A nice figure](file:/figures/foo.png position=fullscreen)
!>

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

{ #category : #'low level visitor tests' }
MicH5PTemplateWriterTest >> testOneSlideBodyWithCode [

	| doc h5p |
	doc := Microdown parse: self slideInMicrodownWithCode.
	h5p := MicH5PTemplateWriter new.
	h5p visit: doc children first.
	self assert: h5p contents equals: '<pre>testMethod\n self assert: 4 foo equals: 55\n</pre>\n<pre>testFoo\n   self assertSpace.\n   self assertSpace2\n   ^ self\n</pre>\n' 
]

{ #category : #'low level visitor tests' }
MicH5PTemplateWriterTest >> testOneSlideBodyWithSimpleCode [

	| doc h5p |
	doc := Microdown parse: self slideInMicrodownWithSimpleCode.
	h5p := MicH5PTemplateWriter new.
	h5p visit: doc children first.
	self assert: h5p contents equals: '<pre>testMethod\n self assert: 4 foo equals: 55\n</pre>\n'
]

{ #category : #tests }
MicH5PTemplateWriterTest >> testOneSlideWithOneFigure [

	| doc h5p |
	doc := Microdown parse: self slideWithFigure.
	h5p := MicH5PTemplateWriter new.
	h5p visit: doc children first.
	self assert: h5p contents equals: '{
            "x": 22.875816993464053,
            "y": 25.821222462742128,
            "width": 61.08050108932463,
            "height": 51.642444925484256,
            "action": {
              "library": "H5P.Image 1.1",
              "params": {
                "contentName": "Image",
                "file": {
                  "path": "images/image-dejfFHSf.png",
                  "mime": "image/png",
                  "copyright": {
                    "license": "U"
                  },
                  "width": 771,
                  "height": 330
                }
              },
              "subContentId": "9cdd1cde-7ffa-4306-b811-cf1287e7c0ba",
              "metadata": {
                "contentType": "Image",
                "license": "U",
                "title": "Untitled Image",
                "authors": [],
                "changes": []
              }
            },
            "alwaysDisplayComments": false,
            "backgroundOpacity": 0,
            "displayAsButton": false,
            "buttonSize": "big",
            "goToSlideType": "specified",
            "invisible": false,
            "solution": ""
          }'
	
	
]

{ #category : #tests }
MicH5PTemplateWriterTest >> testOneSlideWithOneFigureNotH5P [

	| doc fig |
	doc := Microdown parse: self slideWithFigure.
	fig := doc children first children first children first.
	self assert: (fig isKindOf: MicFigureBlock).
	self assert: (fig reference uri segments last) equals: 'foo.png'.
	self assert: (fig arguments at: #position) equals: 'fullscreen'.
	

]

{ #category : #tests }
MicH5PTemplateWriterTest >> testOneSlideWithOneFigureSkipped [

	| doc h5p |
	self skip.
	doc := Microdown 
				resolver: (self memoryFileSystem);
				parse: self slideWithFigure.
	self assert: (doc children first children first isKindOf: MicFigureBlock).
	self assert: (doc children first children first filename) equals: 'figures/foo.png'

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

<!slide|title=Slide2 Bli&tag=nh5p

- slide 2 bullet 1
- slide 2 bullet 2
- slide 2 bullet 3
!>.

<!slide|title=Slide3 blah&tag=nh5p

- slide 3 bullet 1
- bullet 2
- bullet 3
!>'
]

{ #category : #sample }
MicH5PTemplateWriterTest >> twoSlidesInMicrodown [

^ self slideInMicrodown, '

<!slide|title=Slide3 blah&tag=nh5p

- slide 2 bullet 1
- bullet 2
- bullet 2
!>'
]
