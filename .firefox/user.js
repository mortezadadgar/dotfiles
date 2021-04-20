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
// Disable telemetry
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false);
// limit events that can cause a popup
user_pref("dom.popup_allowed_events", "click dblclick mousedown pointerdown");
// Disable WebAssembly -- risk of crytopmining 
user_pref("javascript.options.wasm", false);
// Misc
user_pref("browser.aboutConfig.showWarning", false);
user_pref("ui.key.menuAccessKeyFocuses", false);
user_pref("network.trr.mode", 3);
user_pref("browser.send_pings", false);
user_pref("beacon.enabled", false);
