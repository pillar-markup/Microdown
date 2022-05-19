"
The idea of a picture based writer is that 	we take a pdf + the list of H5P templates and we 
- generate a list of jpeg 
- and an H5P file representing the corresponding slides. 

Right now the creation of the jpeg and the zip of the folder to create the H5P files are done by hand. 


- placeOfTemplateFolder is the location of all the JS files.
- sourceSlideImagesFolder is the place where all the jpeg files are.



The process is the following:

Once we have generated from the PDF the JPEG using

```
pdftoppm -jpeg AboutBasket.pdf Tests-01

pdftoppm -jpeg AboutBasket.pdf -scale-to 1000  Basket
```

- the folder Target contains /content/images will contain all the JPEG
- then we invoke the method `go` as follow

```
self new
		placeOfTemplateFolder: '/Users/ducasse/Workspace/FirstCircle/MyBooks/Bk-Writing/AdvancedOODesign/h5p/Source-Template/';
		sourceSlideImagesFolder: '/Users/ducasse/Workspace/FirstCircle/MyBooks/Bk-Writing/AdvancedOODesign/h5p/AboutBasket-images/';
		go
		
```
- and manually the script

```
cd Target
zip -r -D -X ../Generated.h5p *
cd ../
```


All the manual parts should be done automatically (this is the next step).

```
MicPictureBasedWriter new
	sourcePDF: '/Users/ducasse/Workspace/FirstCircle/MyBooks/Bk-Writing/AdvancedOODesign/h5p/Essence-04-Self.pdf';
	treatSourcePDF;
	go.
```






"
Class {
	#name : #MicPictureBasedWriter,
	#superclass : #Object,
	#instVars : [
		'placeOfTemplateFolder',
		'sourceSlideImagesFolder',
		'slideNames',
		'sourcePDF'
	],
	#category : #'Microdown-H5P'
}

{ #category : #examples }
MicPictureBasedWriter class >> example [
	<script>
	
	self new
		placeOfTemplateFolder: '/Users/ducasse/Workspace/FirstCircle/MyBooks/Bk-Writing/AdvancedOODesign/h5p/Source-Template/';
		sourceSlideImagesFolder: '/Users/ducasse/Workspace/FirstCircle/MyBooks/Bk-Writing/AdvancedOODesign/h5p/AboutBasket-images/';
		go
		
]

{ #category : #operations }
MicPictureBasedWriter >> compressH5P [
	"the following expression works on the parent folder of Target. It produces a working H5P file archive."
	"cd Target
zip -r -D -X ../Generated.h5p *
cd ../"
	"-X  means no extra file attributes 
	-D no Dir entries
	-r recursively"

	
	OSSUnixSubprocess new	
		shellCommand: '/usr/bin/zip -r -D -X ', sourcePDF withoutExtension fullName, '.h5p *';
		workingDirectory: self target fullName;
		runAndWaitOnExitDo: [ :process :outString :errString |
			process isSuccess
				ifTrue: [ Transcript show: 'Command exited correctly with output: ', outString. ]
				ifFalse: [
					Transcript show: 'Command exit with error status: ', process exitStatusInterpreter printString; cr.
					Transcript show: 'Stderr contents: ', errString.
				]
		]
	
]

{ #category : #operations }
MicPictureBasedWriter >> compressH5P2 [
	"the following expression works on the parent folder of Target. It produces a working H5P file archive."
	"cd Target
zip -r -D -X ../Generated.h5p *
cd ../"
	"-X  means no extra file attributes 
	-D no Dir entries
	-r recursively"

	
	OSSUnixSubprocess new	
		shellCommand: '/usr/bin/zip -r -D -X ', sourcePDF withoutExtension fullName, '.h5p *';
		workingDirectory: self target fullName;
		runAndWaitOnExitDo: [ :process :outString :errString |
			process isSuccess
				ifTrue: [ Transcript show: 'Command exited correctly with output: ', outString. ]
				ifFalse: [
					Transcript show: 'Command exit with error status: ', process exitStatusInterpreter printString; cr.
					Transcript show: 'Stderr contents: ', errString.
				]
		]
	
]

{ #category : #operations }
MicPictureBasedWriter >> compressH5POld [
	"the following expression works on the parent folder of Target. It produces a working H5P file archive."
	"cd Target
zip -r -D -X ../Generated.h5p *
cd ../"
	"-X  means no extra file attributes 
	-D no Dir entries
	-r recursively"

"the star is not correct because this is a shell and not the command behavior to expand"
	OSSUnixSubprocess new	
		command: '/usr/bin/zip';
		arguments: {'-r' . '-D'. '-X'. sourcePDF withoutExtension fullName, '.h5p' . '*' };
		workingDirectory: self target fullName;
		runAndWaitOnExitDo: [ :process :outString :errString |
			process isSuccess
				ifTrue: [ Transcript show: 'Command exited correctly with output: ', outString. ]
				ifFalse: [
					Transcript show: 'Command exit with error status: ', process exitStatusInterpreter printString; cr.
					Transcript show: 'Stderr contents: ', errString.
				]
		]
	
]

{ #category : #accessing }
MicPictureBasedWriter >> contentJSON [
	"I point to the place in the source where the content.json should be located."
	
	^ (self target / 'content' / 'content.json') asFileReference
]

{ #category : #operations }
MicPictureBasedWriter >> copyImagesInSource [

	(self target / 'content' / 'images/') ensureDeleteAll.
	
	self sourceSlideImagesFolder copyAllTo: self target / 'content' / 'images/'
]

{ #category : #operations }
MicPictureBasedWriter >> generateContent [

	self contentJSON ensureDelete.
	self contentJSON 
		writeStreamDo: [ :str | str nextPutAll: (self presentationStringForCollection: slideNames sorted )]
]

{ #category : #operations }
MicPictureBasedWriter >> go [
	
	"copy all the template to the target"
	self installSource.
	
	self splitPDF.
	
	"Copy the image from the source to the target"
	self copyImagesInSource.
	
	slideNames := ((self sourceSlideImagesFolder children select: [:each | #('jpeg' 'jpg') includes: each extension]) collect: [:each | each basename]) sorted.
	self generateContent.
	
	self compressH5P
]

{ #category : #operations }
MicPictureBasedWriter >> installSource [

	self target ensureDeleteAll.
	self placeOfTemplateFolder copyAllTo: self target
]

{ #category : #accessing }
MicPictureBasedWriter >> placeOfTemplateFolder [

	^ placeOfTemplateFolder ifNil: [ 
		placeOfTemplateFolder := '/Users/ducasse/Workspace/FirstCircle/MyBooks/Bk-Writing/AdvancedOODesign/h5p/Source-Template/' asFileReference ]
]

{ #category : #accessing }
MicPictureBasedWriter >> placeOfTemplateFolder: aString [

	placeOfTemplateFolder := aString asFileReference 
]

{ #category : #'no template' }
MicPictureBasedWriter >> presentationRawString [
	"STONJSON fromString: self new presentationRawString"
	^ '{"presentation":{"slides":[{"elements":[{"x":0,"y":0,"width":99.99999999999999,"height":100,"action":{"library":"H5P.Image 1.1","params":{"contentName":"Image","file":{"path":"images/image-OE0PKFVx.png","mime":"image/png","copyright":{"license":"U"},"width":310,"height":330}},"subContentId":"5fb6da95-df20-4df0-9de2-aa006c01c08e","metadata":{"contentType":"Image","license":"U","title":"Untitled Image","authors":[],"changes":[]}},"alwaysDisplayComments":false,"backgroundOpacity":0,"displayAsButton":false,"buttonSize":"big","goToSlideType":"specified","invisible":false,"solution":""}],"slideBackgroundSelector":{},"keywords":[{"main":"Nice code eh!"}]}],"keywordListEnabled":true,"globalBackgroundSelector":{},"keywordListAlwaysShow":false,"keywordListAutoHide":false,"keywordListOpacity":100},"override":{"activeSurface":false,"hideSummarySlide":false,"summarySlideSolutionButton":true,"summarySlideRetryButton":true,"enablePrintButton":false,"social":{"showFacebookShare":false,"facebookShare":{"url":"@currentpageurl","quote":"I scored @score out of @maxScore on a task at @currentpageurl."},"showTwitterShare":false,"twitterShare":{"statement":"I scored @score out of @maxScore on a task at @currentpageurl.","url":"@currentpageurl","hashtags":"h5p, course"},"showGoogleShare":false,"googleShareUrl":"@currentpageurl"}},"l10n":{"slide":"Slide","score":"Score","yourScore":"Your Score","maxScore":"Max Score","total":"Total","totalScore":"Total Score","showSolutions":"Show solutions","retry":"Retry","exportAnswers":"Export text","hideKeywords":"Hide sidebar navigation menu","showKeywords":"Show sidebar navigation menu","fullscreen":"Fullscreen","exitFullscreen":"Exit fullscreen","prevSlide":"Previous slide","nextSlide":"Next slide","currentSlide":"Current slide","lastSlide":"Last slide","solutionModeTitle":"Exit solution mode","solutionModeText":"Solution Mode","summaryMultipleTaskText":"Multiple tasks","scoreMessage":"You achieved:","shareFacebook":"Share on Facebook","shareTwitter":"Share on Twitter","shareGoogle":"Share on Google+","summary":"Summary","solutionsButtonTitle":"Show comments","printTitle":"Print","printIngress":"How would you like to print this presentation?","printAllSlides":"Print all slides","printCurrentSlide":"Print current slide","noTitle":"No title","accessibilitySlideNavigationExplanation":"Use left and right arrow to change slide in that direction whenever canvas is selected.","accessibilityCanvasLabel":"Presentation canvas. Use left and right arrow to move between slides.","containsNotCompleted":"@slideName contains not completed interaction","containsCompleted":"@slideName contains completed interaction","slideCount":"Slide @index of @total","containsOnlyCorrect":"@slideName only has correct answers","containsIncorrectAnswers":"@slideName has incorrect answers","shareResult":"Share Result","accessibilityTotalScore":"You got @score of @maxScore points in total","accessibilityEnteredFullscreen":"Entered fullscreen","accessibilityExitedFullscreen":"Exited fullscreen","confirmDialogHeader":"Submit your answers","confirmDialogText":"This will submit your results, do you want to continue?","confirmDialogConfirmText":"Submit and see results"}}'
]

{ #category : #writing }
MicPictureBasedWriter >> presentationString2 [
	"STONJSON fromString: self new presentationString2"
	
	^ '{"presentation":{"slides":[', (self slideStringFor: 'foo.png'), '],"keywordListEnabled":true,"globalBackgroundSelector":{},"keywordListAlwaysShow":false,"keywordListAutoHide":false,"keywordListOpacity":100},"override":{"activeSurface":false,"hideSummarySlide":false,"summarySlideSolutionButton":true,"summarySlideRetryButton":true,"enablePrintButton":false,"social":{"showFacebookShare":false,"facebookShare":{"url":"@currentpageurl","quote":"I scored @score out of @maxScore on a task at @currentpageurl."},"showTwitterShare":false,"twitterShare":{"statement":"I scored @score out of @maxScore on a task at @currentpageurl.","url":"@currentpageurl","hashtags":"h5p, course"},"showGoogleShare":false,"googleShareUrl":"@currentpageurl"}},"l10n":{"slide":"Slide","score":"Score","yourScore":"Your Score","maxScore":"Max Score","total":"Total","totalScore":"Total Score","showSolutions":"Show solutions","retry":"Retry","exportAnswers":"Export text","hideKeywords":"Hide sidebar navigation menu","showKeywords":"Show sidebar navigation menu","fullscreen":"Fullscreen","exitFullscreen":"Exit fullscreen","prevSlide":"Previous slide","nextSlide":"Next slide","currentSlide":"Current slide","lastSlide":"Last slide","solutionModeTitle":"Exit solution mode","solutionModeText":"Solution Mode","summaryMultipleTaskText":"Multiple tasks","scoreMessage":"You achieved:","shareFacebook":"Share on Facebook","shareTwitter":"Share on Twitter","shareGoogle":"Share on Google+","summary":"Summary","solutionsButtonTitle":"Show comments","printTitle":"Print","printIngress":"How would you like to print this presentation?","printAllSlides":"Print all slides","printCurrentSlide":"Print current slide","noTitle":"No title","accessibilitySlideNavigationExplanation":"Use left and right arrow to change slide in that direction whenever canvas is selected.","accessibilityCanvasLabel":"Presentation canvas. Use left and right arrow to move between slides.","containsNotCompleted":"@slideName contains not completed interaction","containsCompleted":"@slideName contains completed interaction","slideCount":"Slide @index of @total","containsOnlyCorrect":"@slideName only has correct answers","containsIncorrectAnswers":"@slideName has incorrect answers","shareResult":"Share Result","accessibilityTotalScore":"You got @score of @maxScore points in total","accessibilityEnteredFullscreen":"Entered fullscreen","accessibilityExitedFullscreen":"Exited fullscreen","confirmDialogHeader":"Submit your answers","confirmDialogText":"This will submit your results, do you want to continue?","confirmDialogConfirmText":"Submit and see results"}}'
]

{ #category : #writing }
MicPictureBasedWriter >> presentationString3 [
	"STONJSON fromString: self new presentationString3"
	
	^ '{"presentation":{"slides":[', (self slideStringFor: '0001.jpg'), ',' , (self slideStringFor: 'foo.png'),  '],"keywordListEnabled":true,"globalBackgroundSelector":{},"keywordListAlwaysShow":false,"keywordListAutoHide":false,"keywordListOpacity":100},"override":{"activeSurface":false,"hideSummarySlide":false,"summarySlideSolutionButton":true,"summarySlideRetryButton":true,"enablePrintButton":false,"social":{"showFacebookShare":false,"facebookShare":{"url":"@currentpageurl","quote":"I scored @score out of @maxScore on a task at @currentpageurl."},"showTwitterShare":false,"twitterShare":{"statement":"I scored @score out of @maxScore on a task at @currentpageurl.","url":"@currentpageurl","hashtags":"h5p, course"},"showGoogleShare":false,"googleShareUrl":"@currentpageurl"}},"l10n":{"slide":"Slide","score":"Score","yourScore":"Your Score","maxScore":"Max Score","total":"Total","totalScore":"Total Score","showSolutions":"Show solutions","retry":"Retry","exportAnswers":"Export text","hideKeywords":"Hide sidebar navigation menu","showKeywords":"Show sidebar navigation menu","fullscreen":"Fullscreen","exitFullscreen":"Exit fullscreen","prevSlide":"Previous slide","nextSlide":"Next slide","currentSlide":"Current slide","lastSlide":"Last slide","solutionModeTitle":"Exit solution mode","solutionModeText":"Solution Mode","summaryMultipleTaskText":"Multiple tasks","scoreMessage":"You achieved:","shareFacebook":"Share on Facebook","shareTwitter":"Share on Twitter","shareGoogle":"Share on Google+","summary":"Summary","solutionsButtonTitle":"Show comments","printTitle":"Print","printIngress":"How would you like to print this presentation?","printAllSlides":"Print all slides","printCurrentSlide":"Print current slide","noTitle":"No title","accessibilitySlideNavigationExplanation":"Use left and right arrow to change slide in that direction whenever canvas is selected.","accessibilityCanvasLabel":"Presentation canvas. Use left and right arrow to move between slides.","containsNotCompleted":"@slideName contains not completed interaction","containsCompleted":"@slideName contains completed interaction","slideCount":"Slide @index of @total","containsOnlyCorrect":"@slideName only has correct answers","containsIncorrectAnswers":"@slideName has incorrect answers","shareResult":"Share Result","accessibilityTotalScore":"You got @score of @maxScore points in total","accessibilityEnteredFullscreen":"Entered fullscreen","accessibilityExitedFullscreen":"Exited fullscreen","confirmDialogHeader":"Submit your answers","confirmDialogText":"This will submit your results, do you want to continue?","confirmDialogConfirmText":"Submit and see results"}}'
]

{ #category : #writing }
MicPictureBasedWriter >> presentationString4 [
	"STONJSON fromString: self new presentationString4"
	
	^ '{"presentation":{"slides":[', (self slidesStringForCollection: #('0001.jpg' 'foo.png' '0001.jpg')),  '],"keywordListEnabled":true,"globalBackgroundSelector":{},"keywordListAlwaysShow":false,"keywordListAutoHide":false,"keywordListOpacity":100},"override":{"activeSurface":false,"hideSummarySlide":false,"summarySlideSolutionButton":true,"summarySlideRetryButton":true,"enablePrintButton":false,"social":{"showFacebookShare":false,"facebookShare":{"url":"@currentpageurl","quote":"I scored @score out of @maxScore on a task at @currentpageurl."},"showTwitterShare":false,"twitterShare":{"statement":"I scored @score out of @maxScore on a task at @currentpageurl.","url":"@currentpageurl","hashtags":"h5p, course"},"showGoogleShare":false,"googleShareUrl":"@currentpageurl"}},"l10n":{"slide":"Slide","score":"Score","yourScore":"Your Score","maxScore":"Max Score","total":"Total","totalScore":"Total Score","showSolutions":"Show solutions","retry":"Retry","exportAnswers":"Export text","hideKeywords":"Hide sidebar navigation menu","showKeywords":"Show sidebar navigation menu","fullscreen":"Fullscreen","exitFullscreen":"Exit fullscreen","prevSlide":"Previous slide","nextSlide":"Next slide","currentSlide":"Current slide","lastSlide":"Last slide","solutionModeTitle":"Exit solution mode","solutionModeText":"Solution Mode","summaryMultipleTaskText":"Multiple tasks","scoreMessage":"You achieved:","shareFacebook":"Share on Facebook","shareTwitter":"Share on Twitter","shareGoogle":"Share on Google+","summary":"Summary","solutionsButtonTitle":"Show comments","printTitle":"Print","printIngress":"How would you like to print this presentation?","printAllSlides":"Print all slides","printCurrentSlide":"Print current slide","noTitle":"No title","accessibilitySlideNavigationExplanation":"Use left and right arrow to change slide in that direction whenever canvas is selected.","accessibilityCanvasLabel":"Presentation canvas. Use left and right arrow to move between slides.","containsNotCompleted":"@slideName contains not completed interaction","containsCompleted":"@slideName contains completed interaction","slideCount":"Slide @index of @total","containsOnlyCorrect":"@slideName only has correct answers","containsIncorrectAnswers":"@slideName has incorrect answers","shareResult":"Share Result","accessibilityTotalScore":"You got @score of @maxScore points in total","accessibilityEnteredFullscreen":"Entered fullscreen","accessibilityExitedFullscreen":"Exited fullscreen","confirmDialogHeader":"Submit your answers","confirmDialogText":"This will submit your results, do you want to continue?","confirmDialogConfirmText":"Submit and see results"}}'
]

{ #category : #writing }
MicPictureBasedWriter >> presentationStringForCollection: aCol [ 
	"STONJSON fromString: self new presentationString4"
	
	^ '{"presentation":{"slides":[', (self slidesStringForCollection: aCol),  '],"keywordListEnabled":true,"globalBackgroundSelector":{},"keywordListAlwaysShow":false,"keywordListAutoHide":false,"keywordListOpacity":100},"override":{"activeSurface":false,"hideSummarySlide":false,"summarySlideSolutionButton":true,"summarySlideRetryButton":true,"enablePrintButton":false,"social":{"showFacebookShare":false,"facebookShare":{"url":"@currentpageurl","quote":"I scored @score out of @maxScore on a task at @currentpageurl."},"showTwitterShare":false,"twitterShare":{"statement":"I scored @score out of @maxScore on a task at @currentpageurl.","url":"@currentpageurl","hashtags":"h5p, course"},"showGoogleShare":false,"googleShareUrl":"@currentpageurl"}},"l10n":{"slide":"Slide","score":"Score","yourScore":"Your Score","maxScore":"Max Score","total":"Total","totalScore":"Total Score","showSolutions":"Show solutions","retry":"Retry","exportAnswers":"Export text","hideKeywords":"Hide sidebar navigation menu","showKeywords":"Show sidebar navigation menu","fullscreen":"Fullscreen","exitFullscreen":"Exit fullscreen","prevSlide":"Previous slide","nextSlide":"Next slide","currentSlide":"Current slide","lastSlide":"Last slide","solutionModeTitle":"Exit solution mode","solutionModeText":"Solution Mode","summaryMultipleTaskText":"Multiple tasks","scoreMessage":"You achieved:","shareFacebook":"Share on Facebook","shareTwitter":"Share on Twitter","shareGoogle":"Share on Google+","summary":"Summary","solutionsButtonTitle":"Show comments","printTitle":"Print","printIngress":"How would you like to print this presentation?","printAllSlides":"Print all slides","printCurrentSlide":"Print current slide","noTitle":"No title","accessibilitySlideNavigationExplanation":"Use left and right arrow to change slide in that direction whenever canvas is selected.","accessibilityCanvasLabel":"Presentation canvas. Use left and right arrow to move between slides.","containsNotCompleted":"@slideName contains not completed interaction","containsCompleted":"@slideName contains completed interaction","slideCount":"Slide @index of @total","containsOnlyCorrect":"@slideName only has correct answers","containsIncorrectAnswers":"@slideName has incorrect answers","shareResult":"Share Result","accessibilityTotalScore":"You got @score of @maxScore points in total","accessibilityEnteredFullscreen":"Entered fullscreen","accessibilityExitedFullscreen":"Exited fullscreen","confirmDialogHeader":"Submit your answers","confirmDialogText":"This will submit your results, do you want to continue?","confirmDialogConfirmText":"Submit and see results"}}'
]

{ #category : #'no template' }
MicPictureBasedWriter >> slideString [
	"STONJSON fromString: self new slideString"
	^ '{"elements":[{"x":0,"y":0,"width":100,"height":100,"action":{"library":"H5P.Image 1.1","params":{"contentName":"Image","file":{"path":"images/image-OE0PKFVx.png","mime":"image/png","copyright":{"license":"U"},"width":310,"height":330}},"subContentId":"5fb6da95-df20-4df0-9de2-aa006c01c08e","metadata":{"contentType":"Image","license":"U","title":"Untitled Image","authors":[],"changes":[]}},"alwaysDisplayComments":false,"backgroundOpacity":0,"displayAsButton":false,"buttonSize":"big","goToSlideType":"specified","invisible":false,"solution":""}],"slideBackgroundSelector":{},"keywords":[{"main":"Nice code eh!"}]}'
]

{ #category : #writing }
MicPictureBasedWriter >> slideStringFor: aString [

	^ '{"elements":[{"x":0,"y":0,"width":100,"height":100,"action":{"library":"H5P.Image 1.1","params":{"contentName":"Image","file":{"path":"images/',aString,'","mime":"image/png","copyright":{"license":"U"},"width":310,"height":330}},"subContentId":"5fb6da95-df20-4df0-9de2-aa006c01c08e","metadata":{"contentType":"Image","license":"U","title":"Untitled Image","authors":[],"changes":[]}},"alwaysDisplayComments":false,"backgroundOpacity":0,"displayAsButton":false,"buttonSize":"big","goToSlideType":"specified","invisible":false,"solution":""}],"slideBackgroundSelector":{},"keywords":[{"main":"Nice code eh!"}]}'
]

{ #category : #writing }
MicPictureBasedWriter >> slidesStringForCollection: aCollection [

	^ String streamContents: [ :st | 
		aCollection 
			do: [ :each | st nextPutAll: (self slideStringFor: each)  ]
			separatedBy: [ st nextPutAll:',' ]
		 ]

]

{ #category : #accessing }
MicPictureBasedWriter >> sourcePDF: aString [

	sourcePDF := aString asFileReference.
	
]

{ #category : #accessing }
MicPictureBasedWriter >> sourceSlideImagesFolder [
	"I'm the place where the slides expressed in jpeg files are. The files in my repository will the copy in the target architecture 
	and used to generate the presentation in the content.json file."
	
	^ sourceSlideImagesFolder
]

{ #category : #accessing }
MicPictureBasedWriter >> sourceSlideImagesFolder: aString [

	sourceSlideImagesFolder := aString asFileReference
]

{ #category : #operations }
MicPictureBasedWriter >> splitPDF [
	
	| treatedPDF cmd |
	treatedPDF := (self sourceSlideImagesFolder / sourcePDF basename).
	
	cmd := '/usr/local/bin/pdftoppm -jpeg ', treatedPDF fullName, ' -scale-to 1000 ', treatedPDF basenameWithoutExtension.
	OSSUnixSubprocess new	
		command: '/usr/local/bin/pdftoppm';
		arguments: {'-jpeg' . treatedPDF fullName . '-scale-to' . '1000' . treatedPDF basenameWithoutExtension };
		workingDirectory: self sourceSlideImagesFolder fullName;
		runAndWaitOnExitDo: [ :process :outString :errString |
		process isSuccess
			ifTrue: [ Transcript show: 'Command exited correctly with output: ', outString. ]
			ifFalse: [
				Transcript show: 'Command exit with error status: ', process exitStatusInterpreter printString; cr.
				Transcript show: 'Stderr contents: ', errString.
			]
	]
	
	
]

{ #category : #accessing }
MicPictureBasedWriter >> target [
	"self new target"
	^ self placeOfTemplateFolder parent / 'Target'
]

{ #category : #accessing }
MicPictureBasedWriter >> targetImageFolder [
	"This is the repository inside the target where we should put the images."
	
	^ (self placeOfTemplateFolder / 'content' / 'images/') asFileReference
]

{ #category : #operations }
MicPictureBasedWriter >> treatSourcePDF [

	self sourceSlideImagesFolder: sourcePDF parent / (sourcePDF basenameWithoutExtension,'Images').
	self sourceSlideImagesFolder ensureDeleteAll.
	self sourceSlideImagesFolder createDirectory.
	sourcePDF copyTo: self sourceSlideImagesFolder / sourcePDF basename .
]

{ #category : #writing }
MicPictureBasedWriter >> writeContentJSONOnDisk: aMicDocument [
	"self new writeContentJSONOnDisk: 2"
	self contentJSON ensureDelete.
	self contentJSON 
		writeStreamDo: [ :str | str nextPutAll: (self presentationStringForCollection: #('0001.jpg' 'foo.png' '0001.jpg' 'foo.png'))]
]
