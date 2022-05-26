"
```
../../vms/100-x64/Pharo.app/Contents/MacOS/Pharo ./H5P.image clap h5p AboutBasket.pdf
```
"
Class {
	#name : #MicH5PCommandLine,
	#superclass : #ClapApplication,
	#category : #'Microdown-H5P'
}

{ #category : #'command line' }
MicH5PCommandLine class >> h5p [
	<commandline>
	
	^ (ClapCommand id: #h5p)
		description: 'To convert to h5p';
		add: ClapFlag forHelp;
		add: ((ClapPositional id: #file) description: 'Files to be converted.');
		meaning: [ :args | 
			args at: #helpFlag ifPresent: [ :help | 
				help value; exitSuccess ].
			(self with: args) execute ]
]

{ #category : #accessing }
MicH5PCommandLine >> argumentAt: identifier [
	^ (arguments at: identifier) value: self
]

{ #category : #accessing }
MicH5PCommandLine >> execute [
	
	MicPictureBasedWriter new
		sourcePDF: (self argumentAt: #file) fullname ;
		treatSourcePDF;
		go;
		compressH5P.
]
