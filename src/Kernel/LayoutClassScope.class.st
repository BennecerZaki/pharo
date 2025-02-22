"
I am layout scope for classes.
"
Class {
	#name : #LayoutClassScope,
	#superclass : #AbstractLayoutScope,
	#type : #variable,
	#instVars : [
		'parentScope'
	],
	#category : #'Kernel-Layout'
}

{ #category : #comparing }
LayoutClassScope >> = other [
	super = other
		ifFalse: [ ^ false ].
	
	self size = other size
		ifFalse: [ ^ false ].
	
	1 to: self size do:  [ :index|
		(self at: index) = (other at: index)
			ifFalse: [ ^ false ]].
	
	^ self parentScope = other parentScope.
]

{ #category : #enumerating }
LayoutClassScope >> allSlotsDo: aBlock [
	parentScope allSlotsDo: aBlock.
	self do: aBlock
]

{ #category : #accessing }
LayoutClassScope >> allVisibleSlots [
	| result |
	result := parentScope allVisibleSlots.
	self do: [ :slot | 
		slot isVisible 
			ifTrue: [ result add: slot ]].
	^ result
]

{ #category : #enumerating }
LayoutClassScope >> do: aBlock [
	1 to: self size do: [ :index |
		aBlock value: (self at: index) ]
]

{ #category : #accessing }
LayoutClassScope >> fieldSize [
	^ parentScope fieldSize + self ownFieldSize.
]

{ #category : #flattening }
LayoutClassScope >> flatten [
	| result |
	result := parentScope flatten.
	result addAll: self.
	^ result
]

{ #category : #enumerating }
LayoutClassScope >> hasBindingThatBeginsWith: aString [
	"Answer true if there is a Slot name that begins with aString, false otherwise"
	
	self allSlotsDo: [:each | 
		(each name beginsWith: aString)
			ifTrue:[^true]].
	^false
]

{ #category : #testing }
LayoutClassScope >> hasFields [
	self do: [ :slot | 
		slot size > 0 
			ifTrue: [ ^ true ]].
	^ parentScope hasFields
]

{ #category : #testing }
LayoutClassScope >> hasSlots [
	self size > 0 
		ifTrue: [ ^ true ].
	^ parentScope hasSlots
]

{ #category : #comparing }
LayoutClassScope >> hash [
	| hash |
	hash := super hash.
	1 to: self size do: [ :i | 
		hash := (hash + (self at: i) hash) hashMultiply].
	^ hash + self parentScope hash hashMultiply.
]

{ #category : #testing }
LayoutClassScope >> ifNotEmpty: aBlock [
	"This scope is not empty so we evaluate the block"
	aBlock value: self
]

{ #category : #accessing }
LayoutClassScope >> ownFieldSize [
	|result|
	result := 0.
	self do: [ :slot | result := result + slot size ].
	^ result
]

{ #category : #accessing }
LayoutClassScope >> parentScope [
	^ parentScope
]

{ #category : #accessing }
LayoutClassScope >> parentScope: aLayoutScope [
	parentScope := aLayoutScope
]

{ #category : #copying }
LayoutClassScope >> postCopy [
	parentScope := parentScope copy.
	1 to: self size do: [ :index | 
		self at: index put: (self at: index) copy ]
]

{ #category : #printing }
LayoutClassScope >> printOn: aStream [
	
	super printOn: aStream.
	self allVisibleSlots printElementsOn: aStream.
]

{ #category : #enumerating }
LayoutClassScope >> reverseDo: aBlock [
	|size|
	size := self size.
	1 to: size do: [ :index |
		aBlock value: (self at: (1 + size - index)) ]
]

{ #category : #accessing }
LayoutClassScope >> slots [
	| result |
	result := OrderedCollection new.
	self do: [ :slot |  result add: slot].
	^ result asArray
]

{ #category : #accessing }
LayoutClassScope >> visibleSlots [
	| result |
	result := OrderedCollection new.
	self do: [ :slot | 
		slot isVisible 
			ifTrue: [ result add: slot ]].
	^ result asArray
]

{ #category : #enumerating }
LayoutClassScope >> withIndexDo: elementAndIndexBlock [ 
	"Just like do: except that the iteration index supplies the second argument to the block"
	1 to: self size do:
		[:index |
		elementAndIndexBlock
			value: (self at: index)
			value: index]
]
