Class {
	#name : #BaselineOfPillarSlideConverter,
	#superclass : #BaselineOf,
	#category : #BaselineOfPillarSlideConverter
}

{ #category : #baselines }
BaselineOfPillarSlideConverter >> baseline: spec [
	<baseline>
	
	spec
		for: #common
		do: [ spec blessing: #baseline.
			spec 
				baseline: 'PetitParser2Core' with: [ spec
					 repository: 'github://kursjan/petitparser2' ];
				package: 'Pillar-Core';
				package: 'Pillar-Model';
				package: 'Pillar-PetitPillar' with: [ spec 
					requires: #( 'PetitParser2Core' 'Pillar-Model' ) ];
				package: 'Microdown-Slide-Utils' with: [ spec 
					requires: #( 'PetitParser2Core' 'Pillar-Model' "I do not put microdown here 
					because I do not want") ]]

	
]
