"
MicJPEGH5PTemplateWriter new 
	writeContentJSONOnDisk: (Microdown parse: MicH5PTemplateWriterTest new mainSlideInMicrodown, MicH5PTemplateWriterTest new oneSlideWithCodeInMicrodown )
"
Class {
	#name : 'MicJPEGH5PTemplateWriter',
	#superclass : 'MicH5PTemplateWriter',
	#category : 'Microdown-H5P',
	#package : 'Microdown-H5P'
}

{ #category : 'as yet unclassified' }
MicJPEGH5PTemplateWriter >> presentationString [

	^ '{
  "presentation": {
    "slides": [
      {
        "elements": [
          {
            "x": 0,
            "y": 0,
            "width": 100,
            "height": 100,
            "action": {
              "library": "H5P.Image 1.1",
              "params": {
                "contentName": "Image",
                "file": {
                  "path": "images/image-OE0PKFVx.png",
                  "mime": "image/png",
                  "copyright": {
                    "license": "U"
                  },
                  "width": 310,
                  "height": 330
                }
              },
              "subContentId": "5fb6da95-df20-4df0-9de2-aa006c01c08e",
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
          }
        ],
        "slideBackgroundSelector": null,
        "keywords": [
          {
            "main": "Nice code eh!"
          }
        ]
      }
    ],
    "keywordListEnabled": true,
    "globalBackgroundSelector": null,
    "keywordListAlwaysShow": false,
    "keywordListAutoHide": false,
    "keywordListOpacity": 100
  },
  "override": {
    "activeSurface": false,
    "hideSummarySlide": false,
    "summarySlideSolutionButton": true,
    "summarySlideRetryButton": true,
    "enablePrintButton": false,
    "social": {
      "showFacebookShare": false,
      "facebookShare": {
        "url": "@currentpageurl",
        "quote": "I scored @score out of @maxScore on a task at @currentpageurl."
      },
      "showTwitterShare": false,
      "twitterShare": {
        "statement": "I scored @score out of @maxScore on a task at @currentpageurl.",
        "url": "@currentpageurl",
        "hashtags": "h5p, course"
      },
      "showGoogleShare": false,
      "googleShareUrl": "@currentpageurl"
    }
  },
  "l10n": {
    "slide": "Slide",
    "score": "Score",
    "yourScore": "Your Score",
    "maxScore": "Max Score",
    "total": "Total",
    "totalScore": "Total Score",
    "showSolutions": "Show solutions",
    "retry": "Retry",
    "exportAnswers": "Export text",
    "hideKeywords": "Hide sidebar navigation menu",
    "showKeywords": "Show sidebar navigation menu",
    "fullscreen": "Fullscreen",
    "exitFullscreen": "Exit fullscreen",
    "prevSlide": "Previous slide",
    "nextSlide": "Next slide",
    "currentSlide": "Current slide",
    "lastSlide": "Last slide",
    "solutionModeTitle": "Exit solution mode",
    "solutionModeText": "Solution Mode",
    "summaryMultipleTaskText": "Multiple tasks",
    "scoreMessage": "You achieved:",
    "shareFacebook": "Share on Facebook",
    "shareTwitter": "Share on Twitter",
    "shareGoogle": "Share on Google+",
    "summary": "Summary",
    "solutionsButtonTitle": "Show comments",
    "printTitle": "Print",
    "printIngress": "How would you like to print this presentation?",
    "printAllSlides": "Print all slides",
    "printCurrentSlide": "Print current slide",
    "noTitle": "No title",
    "accessibilitySlideNavigationExplanation": "Use left and right arrow to change slide in that direction whenever canvas is selected.",
    "accessibilityCanvasLabel": "Presentation canvas. Use left and right arrow to move between slides.",
    "containsNotCompleted": "@slideName contains not completed interaction",
    "containsCompleted": "@slideName contains completed interaction",
    "slideCount": "Slide @index of @total",
    "containsOnlyCorrect": "@slideName only has correct answers",
    "containsIncorrectAnswers": "@slideName has incorrect answers",
    "shareResult": "Share Result",
    "accessibilityTotalScore": "You got @score of @maxScore points in total",
    "accessibilityEnteredFullscreen": "Entered fullscreen",
    "accessibilityExitedFullscreen": "Exited fullscreen",
    "confirmDialogHeader": "Submit your answers",
    "confirmDialogText": "This will submit your results, do you want to continue?",
    "confirmDialogConfirmText": "Submit and see results"
  }
}
'
]

{ #category : 'working templates with parameters' }
MicJPEGH5PTemplateWriter >> slideTemplate [
	"in this version we only embed jpeg"
	
	^ '{
            "elements":[
               {
                  "x":1,
                  "y":1,
                  "width":99,
                  "height":99,
                  "action":{
                     "library":"H5P.AdvancedText 1.1",
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
                        "text":"<h2>{{{SLIDETITLEVARIABLE}}}</h2>\n" 
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
                  "main":"{{{SHORTSLIDETITLEVARIABLE}}}"
               }
            ]
         }'
]
