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
// SSL/TLS hardening
user_pref("security.ssl.require_safe_negotiation", true);
user_pref("security.tls.version.enable-deprecated", false);
user_pref("security.tls.enable_0rtt_data", false);
// Disable DRM
user_pref("media.eme.enabled", false);
// Disable beforeunload
user_pref("dom.disable_beforeunload", true);
// Referers
user_pref("network.http.referer.XOriginPolicy", 1);
user_pref("network.http.referer.XOriginTrimmingPolicy", 2);
// Misc
user_pref("ui.key.menuAccessKeyFocuses", false);
user_pref("network.trr.mode", 3);
