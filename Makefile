PLATFORM_IOS = iOS Simulator,name=iPhone 12 Pro,OS=14.4

build:
	@xcodebuild build \
		-workspace MultiCalculator.xcworkspace \
		-scheme MultiCalculator \
		-destination platform="$(PLATFORM_IOS)"