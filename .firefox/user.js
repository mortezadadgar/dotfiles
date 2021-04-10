// Disable website's notifications
user_pref("dom.webnotifications.enabled", false);
// Block automatically plays media
user_pref("media.autoplay.blocking_policy", 2);
// Disable pocket
user_pref("extensions.pocket.enabled", false);
// Enable Hardware accelerations
user_pref("gfx.webrender.all", true);
// Fingerprint resisting
user_pref("privacy.resistFingerprinting", true);
// Disable WebRTC
user_pref("media.peerconnection.enabled", false);
// Replicate chromium 'Throttle Javascript timers in background'
user_pref("dom.timeout.throttling_delay", 10000);
user_pref("dom.min_background_timeout_value", 60000);
// Show 'Not secure' text on insecure connections
user_pref("security.insecure_connection_text.enabled", true);
// Smooth scrolling
user_pref("general.smoothScroll.lines.durationMaxMS", 125);
user_pref("general.smoothScroll.lines.durationMinMS", 125);
user_pref("general.smoothScroll.mouseWheel.durationMaxMS", 200);
user_pref("general.smoothScroll.mouseWheel.durationMinMS", 100);
user_pref("general.smoothScroll.msdPhysics.enabled", true);
user_pref("general.smoothScroll.other.durationMaxMS", 125);
user_pref("general.smoothScroll.other.durationMinMS", 125);
user_pref("general.smoothScroll.pages.durationMaxMS", 125);
user_pref("general.smoothScroll.pages.durationMinMS", 125);
// Misc
user_pref("ui.key.menuAccessKeyFocuses", false);
user_pref("network.trr.mode", 3);
