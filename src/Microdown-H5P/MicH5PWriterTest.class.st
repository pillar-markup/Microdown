Class {
	#name : #MicH5PWriterTest,
	#superclass : #TestCase,
	#category : #'Microdown-H5P'
}

{ #category : #tests }
MicH5PWriterTest >> assemblingFirstSlide [
	"self assemblingFirstSlide"
	
	^ self withSlidesTemplateString: self mainSlideTemplate 
]

{ #category : #tests }
MicH5PWriterTest >> fullTemplateString [ 
 ^ '{
   "presentation":{
      "slides":[
         {
            "elements":[
               {
                  "x":8.714596949891067,
                  "y":25.821222462742128,
                  "width":81.69934640522877,
                  "height":27.972991001303974,
                  "action":{
                     "library":"H5P.AdvancedText 1.1",
                     "params":{
                        "text":"<p><span style=\"font-size:1.5em\">{{{TITLEVARIABLE}}}</span></p>\n"
                     },
                     "subContentId":"98820042-f742-49f4-af01-56a9eecb226b",
                     "metadata":{
                        "contentType":"Text",
                        "license":"U",
                        "title":"Untitled Text",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                  "x":86.35110294117648,
                  "y":71.00836177254085,
                  "width":13.648910675381265,
                  "height":26.954343775148796,
                  "action":{
                     "library":"H5P.Image 1.1",
                     "params":{
                        "contentName":"Image",
                        "file":{
                           "path":"images/image-b8lco9r6.png",
                           "mime":"image/png",
                           "copyright":{
                              "license":"U"
                           },
                           "width":256,
                           "height":256
                        }
                     },
                     "subContentId":"6f039cb5-677a-4314-ad87-e7ae20b3052d",
                     "metadata":{
                        "contentType":"Image",
                        "license":"U",
                        "title":"Untitled Image",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                  "x":16.051364365971107,
                  "y":60.24268289202926,
                  "width":40.30501089324619,
                  "height":12.910611231371064,
                  "action":{
                     "library":"H5P.AdvancedText 1.1",
                     "params":{
                        "text":"<p>{{{AUTHORVARIABLE}}}</p>\n"
                     },
                     "subContentId":"9fbed056-1cde-4ec3-bc1f-516c724912b1",
                     "metadata":{
                        "contentType":"Text",
                        "license":"U",
                        "title":"Untitled Text",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                  "y":88.22251008103561,
                  "width":14.161220043572985,
                  "height":9.783833332616078,
                  "action":{
                     "library":"H5P.Image 1.1",
                     "params":{
                        "contentName":"Image",
                        "file":{
                           "path":"images/image-FLYhoyME.png",
                           "mime":"image/png",
                           "copyright":{
                              "license":"U"
                           },
                           "width":403,
                           "height":141
                        }
                     },
                     "subContentId":"84fce47f-c9ce-4c1f-95f9-78985029999f",
                     "metadata":{
                        "contentType":"Image",
                        "license":"U",
                        "title":"Untitled Image",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                  "y":4.303537077123688,
                  "width":93.68191721132898,
                  "height":8.607074154247377,
                  "action":{
                     "library":"H5P.AdvancedText 1.1",
                     "params":{
                        "text":"<p>Advanced object-oriented design explained with Pharo</p>\n"
                     },
                     "subContentId":"30b14f98-5f34-467a-b1b0-9f955f411350",
                     "metadata":{
                        "contentType":"Text",
                        "license":"U",
                        "title":"Untitled Text",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                  "x":70.80610021786492,
                  "y":92.5260471581593,
                  "width":19.607843137254903,
                  "height":6.455305615685532,
                  "action":{
                     "library":"H5P.AdvancedText 1.1",
                     "params":{
                        "text":"<p>http://www.pharo.org</p>\n"
                     },
                     "subContentId":"f15bd80f-b6fa-49c5-a26e-78fd09a1dcb6",
                     "metadata":{
                        "contentType":"Text",
                        "license":"U",
                        "title":"Untitled Text",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
            "keywords":[
               {
                  "main":"Cover Slide"
               }
            ],
            "slideBackgroundSelector":{
               
            }
         },
         {
            "elements":[
               {
                  "x":6.5359477124183005,
                  "y":19.365916847056596,
                  "width":37.037037037037,
                  "height":73.160071277275,
                  "action":{
                     "library":"H5P.AdvancedText 1.1",
                     "params":{
                        "text":"<ul>\n\t<li><span style=\"font-size:1.125em\">Cool</span></li>\n\t<li><span style=\"font-size:1.125em\">Nice</span></li>\n\t<li><span style=\"font-size:1.125em\">Super</span></li>\n\t<li><span style=\"font-size:1.125em\">Hyper language</span></li>\n</ul>\n"
                     },
                     "subContentId":"a41dda9d-d25f-47e1-80a7-6dd88158508e",
                     "metadata":{
                        "contentType":"Text",
                        "license":"U",
                        "title":"Untitled Text",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                        "text":"<h2>«& SLIDETITLEVARIABLE»</h2>\n"
                     },
                     "subContentId":"0c4b6088-6d5f-428b-b53b-791a0ca89274",
                     "metadata":{
                        "contentType":"Text",
                        "license":"U",
                        "title":"Untitled Text",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
            "slideBackgroundSelector":{
               
            },
            "keywords":[
               {
                  "main":"Bulleted"
               }
            ]
         },
         {
            "elements":[
               {
                  "x":2.178649237472767,
                  "y":2.151768538561844,
                  "width":95.86056644880175,
                  "height":10.758842692809221,
                  "action":{
                     "library":"H5P.AdvancedText 1.1",
                     "params":{
                        "text":"<h2>Doing Manual Title....</h2>\n"
                     },
                     "subContentId":"b725a0d4-311a-471b-87df-8b56f69b8b6f",
                     "metadata":{
                        "contentType":"Text",
                        "license":"U",
                        "title":"Untitled Text",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                  "x":4.3572984749455,
                  "y":19.365901220455,
                  "width":82.788671023965,
                  "height":51.642403254547,
                  "action":{
                     "library":"H5P.AdvancedText 1.1",
                     "params":{
                        "text":"<pre>testSetLabel\n\n    | codeBlock |\n    codeBlock := self testedClass new.\n    codeBlock label: ''sec123''.\n    self assert: codeBlock hasLabel. \n    self assert: codeBlock label equals: ''sec123''\n</pre>\n"
                     },
                     "subContentId":"4f8b5f81-40ee-4bdd-9fa6-935c850f9da0",
                     "metadata":{
                        "contentType":"Text",
                        "license":"U",
                        "title":"Untitled Text",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
            "slideBackgroundSelector":{
               
            },
            "keywords":[
               {
                  "main":"Code"
               }
            ]
         },
         {
            "elements":[
               {
                  "x":30.000680827887,
                  "y":30.000336213563,
                  "width":40,
                  "height":40,
                  "action":{
                     "library":"H5P.Link 1.3",
                     "params":{
                        "linkWidget":{
                           "protocol":"http://",
                           "url":"www.pharo.org"
                        },
                        "title":"What a great link"
                     },
                     "subContentId":"4160c8f2-8a7c-4e83-ad3b-a6b5415a7b9e",
                     "metadata":{
                        "contentType":"Link",
                        "license":"U"
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
            "slideBackgroundSelector":{
               
            },
            "keywords":[
               {
                  "main":"Link"
               }
            ]
         },
         {
            "elements":[
               {
                  "x":57.734204793028326,
                  "y":83.91897300391192,
                  "width":18.51851851851852,
                  "height":13.21319292326363,
                  "action":{
                     "library":"H5P.Image 1.1",
                     "params":{
                        "contentName":"Image",
                        "file":{
                           "path":"images/image-wFbeHf6p.png",
                           "mime":"image/png",
                           "copyright":{
                              "license":"U"
                           },
                           "width":227,
                           "height":82
                        }
                     },
                     "subContentId":"ae82b3a6-1b91-4133-b9fc-dea9ca6d5b41",
                     "metadata":{
                        "contentType":"Image",
                        "license":"U",
                        "title":"Untitled Image",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                  "x":26.143790849673202,
                  "y":81.76720446535008,
                  "width":10.893246187363834,
                  "height":13.448553366011526,
                  "action":{
                     "library":"H5P.Image 1.1",
                     "params":{
                        "contentName":"Image",
                        "file":{
                           "path":"images/image-9vO0XU26.png",
                           "mime":"image/png",
                           "copyright":{
                              "license":"U"
                           },
                           "width":160,
                           "height":100
                        }
                     },
                     "subContentId":"560b2be2-b5d3-48b6-9d79-ad98b568b7ee",
                     "metadata":{
                        "contentType":"Image",
                        "license":"U",
                        "title":"Untitled Image",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                  "x":42.48366013071895,
                  "y":81.76720446535008,
                  "width":9.803921568627452,
                  "height":13.39475915254748,
                  "action":{
                     "library":"H5P.Image 1.1",
                     "params":{
                        "contentName":"Image",
                        "file":{
                           "path":"images/image-oZNS16yO.png",
                           "mime":"image/png",
                           "copyright":{
                              "license":"U"
                           },
                           "width":133,
                           "height":92
                        }
                     },
                     "subContentId":"b3fd2dcf-de97-49e6-8ba9-7b1e32869b3f",
                     "metadata":{
                        "contentType":"Image",
                        "license":"U",
                        "title":"Untitled Image",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                  "x":80.61002178649238,
                  "y":83.91897300391192,
                  "width":17.429193899782135,
                  "height":13.646924907581543,
                  "action":{
                     "library":"H5P.Image 1.1",
                     "params":{
                        "contentName":"Image",
                        "file":{
                           "path":"images/image-TyojgW30.png",
                           "mime":"image/png",
                           "copyright":{
                              "license":"U"
                           },
                           "width":222,
                           "height":88
                        }
                     },
                     "subContentId":"fee02c70-37b2-4615-a13a-84b397cf0e41",
                     "metadata":{
                        "contentType":"Image",
                        "license":"U",
                        "title":"Untitled Image",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                  "x":1.0893246187363834,
                  "y":81.76720446535008,
                  "width":19.607843137254903,
                  "height":13.949506599474109,
                  "action":{
                     "library":"H5P.Image 1.1",
                     "params":{
                        "contentName":"Image",
                        "file":{
                           "path":"images/image-MHF07lsl.png",
                           "mime":"image/png",
                           "copyright":{
                              "license":"U"
                           },
                           "width":472,
                           "height":170
                        }
                     },
                     "subContentId":"ff04b6d1-0612-4d3e-a164-63b211b0e5e8",
                     "metadata":{
                        "contentType":"Image",
                        "license":"U",
                        "title":"Untitled Image",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                  "x":37.03703703703704,
                  "y":62.40128761829348,
                  "width":18.51851851851852,
                  "height":12.796309286602659,
                  "action":{
                     "library":"H5P.Image 1.1",
                     "params":{
                        "contentName":"Image",
                        "file":{
                           "path":"images/image-kyGO23Dp.png",
                           "mime":"image/png",
                           "copyright":{
                              "license":"U"
                           },
                           "width":403,
                           "height":141
                        }
                     },
                     "subContentId":"0df21089-995e-4eae-b37a-fa1c5f500dac",
                     "metadata":{
                        "contentType":"Image",
                        "license":"U",
                        "title":"Untitled Image",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                  "x":19.607843137254903,
                  "y":30.124759539865817,
                  "width":55.55555555555556,
                  "height":39.999440540179975,
                  "action":{
                     "library":"H5P.AdvancedText 1.1",
                     "params":{
                        "text":"<p style=\"text-align:center\"><span style=\"font-size:1.375em\">S. Ducasse, L. Fabresse, G. Polito, P. Tesone </span></p>\n\n<p style=\"text-align:center\"><span style=\"font-size:1.125em\">Copyright 2022</span></p>\n\n<p> </p>\n"
                     },
                     "subContentId":"a5116483-6063-4cf8-8155-dd08bd8526b0",
                     "metadata":{
                        "contentType":"Text",
                        "license":"U",
                        "title":"Untitled Text",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
            "slideBackgroundSelector":{
               
            },
            "keywords":[
               {
                  "main":"End"
               }
            ]
         }
      ],
      "keywordListEnabled":true,
      "globalBackgroundSelector":{
         
      },
      "keywordListAlwaysShow":false,
      "keywordListAutoHide":false,
      "keywordListOpacity":100
   },
   "override":{
      "activeSurface":false,
      "hideSummarySlide":false,
      "summarySlideSolutionButton":true,
      "summarySlideRetryButton":true,
      "enablePrintButton":false,
      "social":{
         "showFacebookShare":false,
         "facebookShare":{
            "url":"@currentpageurl",
            "quote":"I scored @score out of @maxScore on a task at @currentpageurl."
         },
         "showTwitterShare":false,
         "twitterShare":{
            "statement":"I scored @score out of @maxScore on a task at @currentpageurl.",
            "url":"@currentpageurl",
            "hashtags":"h5p, course"
         },
         "showGoogleShare":false,
         "googleShareUrl":"@currentpageurl"
      }
   },
   "l10n":{
      "slide":"Slide",
      "score":"Score",
      "yourScore":"Your Score",
      "maxScore":"Max Score",
      "total":"Total",
      "totalScore":"Total Score",
      "showSolutions":"Show solutions",
      "retry":"Retry",
      "exportAnswers":"Export text",
      "hideKeywords":"Hide sidebar navigation menu",
      "showKeywords":"Show sidebar navigation menu",
      "fullscreen":"Fullscreen",
      "exitFullscreen":"Exit fullscreen",
      "prevSlide":"Previous slide",
      "nextSlide":"Next slide",
      "currentSlide":"Current slide",
      "lastSlide":"Last slide",
      "solutionModeTitle":"Exit solution mode",
      "solutionModeText":"Solution Mode",
      "summaryMultipleTaskText":"Multiple tasks",
      "scoreMessage":"You achieved:",
      "shareFacebook":"Share on Facebook",
      "shareTwitter":"Share on Twitter",
      "shareGoogle":"Share on Google+",
      "summary":"Summary",
      "solutionsButtonTitle":"Show comments",
      "printTitle":"Print",
      "printIngress":"How would you like to print this presentation?",
      "printAllSlides":"Print all slides",
      "printCurrentSlide":"Print current slide",
      "noTitle":"No title",
      "accessibilitySlideNavigationExplanation":"Use left and right arrow to change slide in that direction whenever canvas is selected.",
      "accessibilityCanvasLabel":"Presentation canvas. Use left and right arrow to move between slides.",
      "containsNotCompleted":"@slideName contains not completed interaction",
      "containsCompleted":"@slideName contains completed interaction",
      "slideCount":"Slide @index of @total",
      "containsOnlyCorrect":"@slideName only has correct answers",
      "containsIncorrectAnswers":"@slideName has incorrect answers",
      "shareResult":"Share Result",
      "accessibilityTotalScore":"You got @score of @maxScore points in total",
      "accessibilityEnteredFullscreen":"Entered fullscreen",
      "accessibilityExitedFullscreen":"Exited fullscreen",
      "confirmDialogHeader":"Submit your answers",
      "confirmDialogText":"This will submit your results, do you want to continue?",
      "confirmDialogConfirmText":"Submit and see results"
   }
}'
]

{ #category : #tests }
MicH5PWriterTest >> mainSlideTemplate [

		^ '{
                  "x":8.714596949891067,
                  "y":25.821222462742128,
                  "width":81.69934640522877,
                  "height":27.972991001303974,
                  "action":{
                     "library":"H5P.AdvancedText 1.1",
                     "params":{
                        "text":"<p><span style=\"font-size:1.5em\">{{{TITLEVARIABLE}}}</span></p>\n"
                     },
                     "subContentId":"98820042-f742-49f4-af01-56a9eecb226b",
                     "metadata":{
                        "contentType":"Text",
                        "license":"U",
                        "title":"Untitled Text",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                  "x":86.35110294117648,
                  "y":71.00836177254085,
                  "width":13.648910675381265,
                  "height":26.954343775148796,
                  "action":{
                     "library":"H5P.Image 1.1",
                     "params":{
                        "contentName":"Image",
                        "file":{
                           "path":"images/image-b8lco9r6.png",
                           "mime":"image/png",
                           "copyright":{
                              "license":"U"
                           },
                           "width":256,
                           "height":256
                        }
                     },
                     "subContentId":"6f039cb5-677a-4314-ad87-e7ae20b3052d",
                     "metadata":{
                        "contentType":"Image",
                        "license":"U",
                        "title":"Untitled Image",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                  "x":16.051364365971107,
                  "y":60.24268289202926,
                  "width":40.30501089324619,
                  "height":12.910611231371064,
                  "action":{
                     "library":"H5P.AdvancedText 1.1",
                     "params":{
                        "text":"<p>{{{AUTHORVARIABLE}}}</p>\n"
                     },
                     "subContentId":"9fbed056-1cde-4ec3-bc1f-516c724912b1",
                     "metadata":{
                        "contentType":"Text",
                        "license":"U",
                        "title":"Untitled Text",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                  "y":88.22251008103561,
                  "width":14.161220043572985,
                  "height":9.783833332616078,
                  "action":{
                     "library":"H5P.Image 1.1",
                     "params":{
                        "contentName":"Image",
                        "file":{
                           "path":"images/image-FLYhoyME.png",
                           "mime":"image/png",
                           "copyright":{
                              "license":"U"
                           },
                           "width":403,
                           "height":141
                        }
                     },
                     "subContentId":"84fce47f-c9ce-4c1f-95f9-78985029999f",
                     "metadata":{
                        "contentType":"Image",
                        "license":"U",
                        "title":"Untitled Image",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                  "y":4.303537077123688,
                  "width":93.68191721132898,
                  "height":8.607074154247377,
                  "action":{
                     "library":"H5P.AdvancedText 1.1",
                     "params":{
                        "text":"<p>Advanced object-oriented design explained with Pharo</p>\n"
                     },
                     "subContentId":"30b14f98-5f34-467a-b1b0-9f955f411350",
                     "metadata":{
                        "contentType":"Text",
                        "license":"U",
                        "title":"Untitled Text",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                  "x":70.80610021786492,
                  "y":92.5260471581593,
                  "width":19.607843137254903,
                  "height":6.455305615685532,
                  "action":{
                     "library":"H5P.AdvancedText 1.1",
                     "params":{
                        "text":"<p>http://www.pharo.org</p>\n"
                     },
                     "subContentId":"f15bd80f-b6fa-49c5-a26e-78fd09a1dcb6",
                     "metadata":{
                        "contentType":"Text",
                        "license":"U",
                        "title":"Untitled Text",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
            "keywords":[
               {
                  "main":"Cover Slide"
               }
            ],
            "slideBackgroundSelector":{
               
            }
         }'
]

{ #category : #tests }
MicH5PWriterTest >> snippet [

	 '/Users/ducasse/Workspace/FirstCircle/MyBooks/Bk-Writing/AdvancedOODesign/h5p/ValidatedJSON/content4.json' asFileReference contents asMustacheTemplate 
	value: ({ 'TITLEVARIABLE' -> 'ZORKONGLE' . 'AUTHORVARIABLE' -> 'Three amigos' }) asDictionary.
]

{ #category : #tests }
MicH5PWriterTest >> templateString [ 
 ^ '{
   "presentation":{
      "slides":[
         {
            "elements":[
               {
                  "x":8.714596949891067,
                  "y":25.821222462742128,
                  "width":81.69934640522877,
                  "height":27.972991001303974,
                  "action":{
                     "library":"H5P.AdvancedText 1.1",
                     "params":{
                        "text":"<p><span style=\"font-size:1.5em\">{{{TITLEVARIABLE}}}</span></p>\n"
                     },
                     "subContentId":"98820042-f742-49f4-af01-56a9eecb226b",
                     "metadata":{
                        "contentType":"Text",
                        "license":"U",
                        "title":"Untitled Text",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                  "x":86.35110294117648,
                  "y":71.00836177254085,
                  "width":13.648910675381265,
                  "height":26.954343775148796,
                  "action":{
                     "library":"H5P.Image 1.1",
                     "params":{
                        "contentName":"Image",
                        "file":{
                           "path":"images/image-b8lco9r6.png",
                           "mime":"image/png",
                           "copyright":{
                              "license":"U"
                           },
                           "width":256,
                           "height":256
                        }
                     },
                     "subContentId":"6f039cb5-677a-4314-ad87-e7ae20b3052d",
                     "metadata":{
                        "contentType":"Image",
                        "license":"U",
                        "title":"Untitled Image",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                  "x":16.051364365971107,
                  "y":60.24268289202926,
                  "width":40.30501089324619,
                  "height":12.910611231371064,
                  "action":{
                     "library":"H5P.AdvancedText 1.1",
                     "params":{
                        "text":"<p>{{{AUTHORVARIABLE}}}</p>\n"
                     },
                     "subContentId":"9fbed056-1cde-4ec3-bc1f-516c724912b1",
                     "metadata":{
                        "contentType":"Text",
                        "license":"U",
                        "title":"Untitled Text",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                  "y":88.22251008103561,
                  "width":14.161220043572985,
                  "height":9.783833332616078,
                  "action":{
                     "library":"H5P.Image 1.1",
                     "params":{
                        "contentName":"Image",
                        "file":{
                           "path":"images/image-FLYhoyME.png",
                           "mime":"image/png",
                           "copyright":{
                              "license":"U"
                           },
                           "width":403,
                           "height":141
                        }
                     },
                     "subContentId":"84fce47f-c9ce-4c1f-95f9-78985029999f",
                     "metadata":{
                        "contentType":"Image",
                        "license":"U",
                        "title":"Untitled Image",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                  "y":4.303537077123688,
                  "width":93.68191721132898,
                  "height":8.607074154247377,
                  "action":{
                     "library":"H5P.AdvancedText 1.1",
                     "params":{
                        "text":"<p>Advanced object-oriented design explained with Pharo</p>\n"
                     },
                     "subContentId":"30b14f98-5f34-467a-b1b0-9f955f411350",
                     "metadata":{
                        "contentType":"Text",
                        "license":"U",
                        "title":"Untitled Text",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                  "x":70.80610021786492,
                  "y":92.5260471581593,
                  "width":19.607843137254903,
                  "height":6.455305615685532,
                  "action":{
                     "library":"H5P.AdvancedText 1.1",
                     "params":{
                        "text":"<p>http://www.pharo.org</p>\n"
                     },
                     "subContentId":"f15bd80f-b6fa-49c5-a26e-78fd09a1dcb6",
                     "metadata":{
                        "contentType":"Text",
                        "license":"U",
                        "title":"Untitled Text",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
            "keywords":[
               {
                  "main":"Cover Slide"
               }
            ],
            "slideBackgroundSelector":{
               
            }
         },
         {
            "elements":[
               {
                  "x":6.5359477124183005,
                  "y":19.365916847056596,
                  "width":37.037037037037,
                  "height":73.160071277275,
                  "action":{
                     "library":"H5P.AdvancedText 1.1",
                     "params":{
                        "text":"<ul>\n\t<li><span style=\"font-size:1.125em\">Cool</span></li>\n\t<li><span style=\"font-size:1.125em\">Nice</span></li>\n\t<li><span style=\"font-size:1.125em\">Super</span></li>\n\t<li><span style=\"font-size:1.125em\">Hyper language</span></li>\n</ul>\n"
                     },
                     "subContentId":"a41dda9d-d25f-47e1-80a7-6dd88158508e",
                     "metadata":{
                        "contentType":"Text",
                        "license":"U",
                        "title":"Untitled Text",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                        "text":"<h2>«& SLIDETITLEVARIABLE»</h2>\n"
                     },
                     "subContentId":"0c4b6088-6d5f-428b-b53b-791a0ca89274",
                     "metadata":{
                        "contentType":"Text",
                        "license":"U",
                        "title":"Untitled Text",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
            "slideBackgroundSelector":{
               
            },
            "keywords":[
               {
                  "main":"Bulleted"
               }
            ]
         },
         {
            "elements":[
               {
                  "x":2.178649237472767,
                  "y":2.151768538561844,
                  "width":95.86056644880175,
                  "height":10.758842692809221,
                  "action":{
                     "library":"H5P.AdvancedText 1.1",
                     "params":{
                        "text":"<h2>Doing Manual Title....</h2>\n"
                     },
                     "subContentId":"b725a0d4-311a-471b-87df-8b56f69b8b6f",
                     "metadata":{
                        "contentType":"Text",
                        "license":"U",
                        "title":"Untitled Text",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                  "x":4.3572984749455,
                  "y":19.365901220455,
                  "width":82.788671023965,
                  "height":51.642403254547,
                  "action":{
                     "library":"H5P.AdvancedText 1.1",
                     "params":{
                        "text":"<pre>testSetLabel\n\n    | codeBlock |\n    codeBlock := self testedClass new.\n    codeBlock label: ''sec123''.\n    self assert: codeBlock hasLabel. \n    self assert: codeBlock label equals: ''sec123''\n</pre>\n"
                     },
                     "subContentId":"4f8b5f81-40ee-4bdd-9fa6-935c850f9da0",
                     "metadata":{
                        "contentType":"Text",
                        "license":"U",
                        "title":"Untitled Text",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
            "slideBackgroundSelector":{
               
            },
            "keywords":[
               {
                  "main":"Code"
               }
            ]
         },
         {
            "elements":[
               {
                  "x":30.000680827887,
                  "y":30.000336213563,
                  "width":40,
                  "height":40,
                  "action":{
                     "library":"H5P.Link 1.3",
                     "params":{
                        "linkWidget":{
                           "protocol":"http://",
                           "url":"www.pharo.org"
                        },
                        "title":"What a great link"
                     },
                     "subContentId":"4160c8f2-8a7c-4e83-ad3b-a6b5415a7b9e",
                     "metadata":{
                        "contentType":"Link",
                        "license":"U"
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
            "slideBackgroundSelector":{
               
            },
            "keywords":[
               {
                  "main":"Link"
               }
            ]
         },
         {
            "elements":[
               {
                  "x":57.734204793028326,
                  "y":83.91897300391192,
                  "width":18.51851851851852,
                  "height":13.21319292326363,
                  "action":{
                     "library":"H5P.Image 1.1",
                     "params":{
                        "contentName":"Image",
                        "file":{
                           "path":"images/image-wFbeHf6p.png",
                           "mime":"image/png",
                           "copyright":{
                              "license":"U"
                           },
                           "width":227,
                           "height":82
                        }
                     },
                     "subContentId":"ae82b3a6-1b91-4133-b9fc-dea9ca6d5b41",
                     "metadata":{
                        "contentType":"Image",
                        "license":"U",
                        "title":"Untitled Image",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                  "x":26.143790849673202,
                  "y":81.76720446535008,
                  "width":10.893246187363834,
                  "height":13.448553366011526,
                  "action":{
                     "library":"H5P.Image 1.1",
                     "params":{
                        "contentName":"Image",
                        "file":{
                           "path":"images/image-9vO0XU26.png",
                           "mime":"image/png",
                           "copyright":{
                              "license":"U"
                           },
                           "width":160,
                           "height":100
                        }
                     },
                     "subContentId":"560b2be2-b5d3-48b6-9d79-ad98b568b7ee",
                     "metadata":{
                        "contentType":"Image",
                        "license":"U",
                        "title":"Untitled Image",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                  "x":42.48366013071895,
                  "y":81.76720446535008,
                  "width":9.803921568627452,
                  "height":13.39475915254748,
                  "action":{
                     "library":"H5P.Image 1.1",
                     "params":{
                        "contentName":"Image",
                        "file":{
                           "path":"images/image-oZNS16yO.png",
                           "mime":"image/png",
                           "copyright":{
                              "license":"U"
                           },
                           "width":133,
                           "height":92
                        }
                     },
                     "subContentId":"b3fd2dcf-de97-49e6-8ba9-7b1e32869b3f",
                     "metadata":{
                        "contentType":"Image",
                        "license":"U",
                        "title":"Untitled Image",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                  "x":80.61002178649238,
                  "y":83.91897300391192,
                  "width":17.429193899782135,
                  "height":13.646924907581543,
                  "action":{
                     "library":"H5P.Image 1.1",
                     "params":{
                        "contentName":"Image",
                        "file":{
                           "path":"images/image-TyojgW30.png",
                           "mime":"image/png",
                           "copyright":{
                              "license":"U"
                           },
                           "width":222,
                           "height":88
                        }
                     },
                     "subContentId":"fee02c70-37b2-4615-a13a-84b397cf0e41",
                     "metadata":{
                        "contentType":"Image",
                        "license":"U",
                        "title":"Untitled Image",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                  "x":1.0893246187363834,
                  "y":81.76720446535008,
                  "width":19.607843137254903,
                  "height":13.949506599474109,
                  "action":{
                     "library":"H5P.Image 1.1",
                     "params":{
                        "contentName":"Image",
                        "file":{
                           "path":"images/image-MHF07lsl.png",
                           "mime":"image/png",
                           "copyright":{
                              "license":"U"
                           },
                           "width":472,
                           "height":170
                        }
                     },
                     "subContentId":"ff04b6d1-0612-4d3e-a164-63b211b0e5e8",
                     "metadata":{
                        "contentType":"Image",
                        "license":"U",
                        "title":"Untitled Image",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                  "x":37.03703703703704,
                  "y":62.40128761829348,
                  "width":18.51851851851852,
                  "height":12.796309286602659,
                  "action":{
                     "library":"H5P.Image 1.1",
                     "params":{
                        "contentName":"Image",
                        "file":{
                           "path":"images/image-kyGO23Dp.png",
                           "mime":"image/png",
                           "copyright":{
                              "license":"U"
                           },
                           "width":403,
                           "height":141
                        }
                     },
                     "subContentId":"0df21089-995e-4eae-b37a-fa1c5f500dac",
                     "metadata":{
                        "contentType":"Image",
                        "license":"U",
                        "title":"Untitled Image",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
                  "x":19.607843137254903,
                  "y":30.124759539865817,
                  "width":55.55555555555556,
                  "height":39.999440540179975,
                  "action":{
                     "library":"H5P.AdvancedText 1.1",
                     "params":{
                        "text":"<p style=\"text-align:center\"><span style=\"font-size:1.375em\">S. Ducasse, L. Fabresse, G. Polito, P. Tesone </span></p>\n\n<p style=\"text-align:center\"><span style=\"font-size:1.125em\">Copyright 2022</span></p>\n\n<p> </p>\n"
                     },
                     "subContentId":"a5116483-6063-4cf8-8155-dd08bd8526b0",
                     "metadata":{
                        "contentType":"Text",
                        "license":"U",
                        "title":"Untitled Text",
                        "authors":[
                           
                        ],
                        "changes":[
                           
                        ]
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
            "slideBackgroundSelector":{
               
            },
            "keywords":[
               {
                  "main":"End"
               }
            ]
         }
      ],
      "keywordListEnabled":true,
      "globalBackgroundSelector":{
         
      },
      "keywordListAlwaysShow":false,
      "keywordListAutoHide":false,
      "keywordListOpacity":100
   },
   "override":{
      "activeSurface":false,
      "hideSummarySlide":false,
      "summarySlideSolutionButton":true,
      "summarySlideRetryButton":true,
      "enablePrintButton":false,
      "social":{
         "showFacebookShare":false,
         "facebookShare":{
            "url":"@currentpageurl",
            "quote":"I scored @score out of @maxScore on a task at @currentpageurl."
         },
         "showTwitterShare":false,
         "twitterShare":{
            "statement":"I scored @score out of @maxScore on a task at @currentpageurl.",
            "url":"@currentpageurl",
            "hashtags":"h5p, course"
         },
         "showGoogleShare":false,
         "googleShareUrl":"@currentpageurl"
      }
   },
   "l10n":{
      "slide":"Slide",
      "score":"Score",
      "yourScore":"Your Score",
      "maxScore":"Max Score",
      "total":"Total",
      "totalScore":"Total Score",
      "showSolutions":"Show solutions",
      "retry":"Retry",
      "exportAnswers":"Export text",
      "hideKeywords":"Hide sidebar navigation menu",
      "showKeywords":"Show sidebar navigation menu",
      "fullscreen":"Fullscreen",
      "exitFullscreen":"Exit fullscreen",
      "prevSlide":"Previous slide",
      "nextSlide":"Next slide",
      "currentSlide":"Current slide",
      "lastSlide":"Last slide",
      "solutionModeTitle":"Exit solution mode",
      "solutionModeText":"Solution Mode",
      "summaryMultipleTaskText":"Multiple tasks",
      "scoreMessage":"You achieved:",
      "shareFacebook":"Share on Facebook",
      "shareTwitter":"Share on Twitter",
      "shareGoogle":"Share on Google+",
      "summary":"Summary",
      "solutionsButtonTitle":"Show comments",
      "printTitle":"Print",
      "printIngress":"How would you like to print this presentation?",
      "printAllSlides":"Print all slides",
      "printCurrentSlide":"Print current slide",
      "noTitle":"No title",
      "accessibilitySlideNavigationExplanation":"Use left and right arrow to change slide in that direction whenever canvas is selected.",
      "accessibilityCanvasLabel":"Presentation canvas. Use left and right arrow to move between slides.",
      "containsNotCompleted":"@slideName contains not completed interaction",
      "containsCompleted":"@slideName contains completed interaction",
      "slideCount":"Slide @index of @total",
      "containsOnlyCorrect":"@slideName only has correct answers",
      "containsIncorrectAnswers":"@slideName has incorrect answers",
      "shareResult":"Share Result",
      "accessibilityTotalScore":"You got @score of @maxScore points in total",
      "accessibilityEnteredFullscreen":"Entered fullscreen",
      "accessibilityExitedFullscreen":"Exited fullscreen",
      "confirmDialogHeader":"Submit your answers",
      "confirmDialogText":"This will submit your results, do you want to continue?",
      "confirmDialogConfirmText":"Submit and see results"
   }
}'
]

{ #category : #tests }
MicH5PWriterTest >> testAssembleFirstSlide [

	| writer |
	writer := MicH5PWriter new. 
	writer 
]

{ #category : #tests }
MicH5PWriterTest >> testMetaDataGoesToFirstSlide [
]

{ #category : #tests }
MicH5PWriterTest >> testSlides [

	| doc |
	doc := Microdown parse: 

'
{
    "title":"About Validation",
    "subtitle":"A pretext to talk about optional actions",
    "author":""
}

<?slide|title=Slide2 Bli&tag=nh5p

- slide 1 bullet 1
- slide 1 bullet 1
- slide 1 bullet 1
?>.

<?slide|title=Slide3 blah&tag=nh5p

- slide 2 bullet 1
- bullet 2
- bullet 2
?>'
]

{ #category : #tests }
MicH5PWriterTest >> withSlidesTemplateString: aSlidesString [
 ^ '{
   "presentation":{
      "slides":[
	',
   		
		aSlidesString 
			      
 	,
	'	
      ],
      "keywordListEnabled":true,
      "globalBackgroundSelector":{
         
      },
      "keywordListAlwaysShow":false,
      "keywordListAutoHide":false,
      "keywordListOpacity":100
   },
   "override":{
      "activeSurface":false,
      "hideSummarySlide":false,
      "summarySlideSolutionButton":true,
      "summarySlideRetryButton":true,
      "enablePrintButton":false,
      "social":{
         "showFacebookShare":false,
         "facebookShare":{
            "url":"@currentpageurl",
            "quote":"I scored @score out of @maxScore on a task at @currentpageurl."
         },
         "showTwitterShare":false,
         "twitterShare":{
            "statement":"I scored @score out of @maxScore on a task at @currentpageurl.",
            "url":"@currentpageurl",
            "hashtags":"h5p, course"
         },
         "showGoogleShare":false,
         "googleShareUrl":"@currentpageurl"
      }
   },
   "l10n":{
      "slide":"Slide",
      "score":"Score",
      "yourScore":"Your Score",
      "maxScore":"Max Score",
      "total":"Total",
      "totalScore":"Total Score",
      "showSolutions":"Show solutions",
      "retry":"Retry",
      "exportAnswers":"Export text",
      "hideKeywords":"Hide sidebar navigation menu",
      "showKeywords":"Show sidebar navigation menu",
      "fullscreen":"Fullscreen",
      "exitFullscreen":"Exit fullscreen",
      "prevSlide":"Previous slide",
      "nextSlide":"Next slide",
      "currentSlide":"Current slide",
      "lastSlide":"Last slide",
      "solutionModeTitle":"Exit solution mode",
      "solutionModeText":"Solution Mode",
      "summaryMultipleTaskText":"Multiple tasks",
      "scoreMessage":"You achieved:",
      "shareFacebook":"Share on Facebook",
      "shareTwitter":"Share on Twitter",
      "shareGoogle":"Share on Google+",
      "summary":"Summary",
      "solutionsButtonTitle":"Show comments",
      "printTitle":"Print",
      "printIngress":"How would you like to print this presentation?",
      "printAllSlides":"Print all slides",
      "printCurrentSlide":"Print current slide",
      "noTitle":"No title",
      "accessibilitySlideNavigationExplanation":"Use left and right arrow to change slide in that direction whenever canvas is selected.",
      "accessibilityCanvasLabel":"Presentation canvas. Use left and right arrow to move between slides.",
      "containsNotCompleted":"@slideName contains not completed interaction",
      "containsCompleted":"@slideName contains completed interaction",
      "slideCount":"Slide @index of @total",
      "containsOnlyCorrect":"@slideName only has correct answers",
      "containsIncorrectAnswers":"@slideName has incorrect answers",
      "shareResult":"Share Result",
      "accessibilityTotalScore":"You got @score of @maxScore points in total",
      "accessibilityEnteredFullscreen":"Entered fullscreen",
      "accessibilityExitedFullscreen":"Exited fullscreen",
      "confirmDialogHeader":"Submit your answers",
      "confirmDialogText":"This will submit your results, do you want to continue?",
      "confirmDialogConfirmText":"Submit and see results"
   }
}'
]

{ #category : #tests }
MicH5PWriterTest >> writeContentJSONOnDisk [
	"self new writeContentJSONOnDisk"

	(FileSystem workingDirectory /'content.json') writeStreamDo: [ :str | str nextPutAll: self assemblingFirstSlide  ]
]
