import CoreAudio
import Testing
@testable import MuesliNativeApp

@Suite("AudioRouteClassifier")
struct AudioRouteClassifierTests {
    @Test("AirPods output is headphone-like")
    func airPodsOutputIsHeadphoneLike() {
        let route = AudioRouteClassifier.outputRouteKind(
            for: AudioOutputDeviceDescription(
                name: nil,
                transportType: kAudioDeviceTransportTypeBluetooth,
                hasOutputStreams: true
            )
        )

        #expect(route == .headphoneLike)
    }

    @Test("generic Bluetooth output defaults to headphone-like")
    func genericBluetoothOutputDefaultsToHeadphoneLike() {
        let route = AudioRouteClassifier.outputRouteKind(
            for: AudioOutputDeviceDescription(
                name: "Wireless Audio",
                transportType: kAudioDeviceTransportTypeBluetooth,
                hasOutputStreams: true
            )
        )

        #expect(route == .headphoneLike)
    }

    @Test("Bluetooth route does not depend on brand or product words")
    func bluetoothRouteDoesNotDependOnBrandOrProductWords() {
        let route = AudioRouteClassifier.outputRouteKind(
            for: AudioOutputDeviceDescription(
                name: "Generic Output",
                transportType: kAudioDeviceTransportTypeBluetooth,
                hasOutputStreams: true
            )
        )

        #expect(route == .headphoneLike)
    }

    @Test("built-in speakers are speaker-like")
    func builtInSpeakersAreSpeakerLike() {
        let route = AudioRouteClassifier.outputRouteKind(
            for: AudioOutputDeviceDescription(
                name: "MacBook Pro Speakers",
                transportType: kAudioDeviceTransportTypeBuiltIn,
                hasOutputStreams: true
            )
        )

        #expect(route == .speakerLike)
    }

    @Test("device names do not override transport classification")
    func deviceNamesDoNotOverrideTransportClassification() {
        let route = AudioRouteClassifier.outputRouteKind(
            for: AudioOutputDeviceDescription(
                name: "External Headphones",
                transportType: kAudioDeviceTransportTypeBuiltIn,
                hasOutputStreams: true
            )
        )

        #expect(route == .speakerLike)
    }

    @Test("devices without output streams are unknown")
    func devicesWithoutOutputStreamsAreUnknown() {
        let route = AudioRouteClassifier.outputRouteKind(
            for: AudioOutputDeviceDescription(
                name: "MacBook Pro Microphone",
                transportType: kAudioDeviceTransportTypeBuiltIn,
                hasOutputStreams: false
            )
        )

        #expect(route == .unknown)
    }
}
