/* force enable hw acceleration */
user_pref("layers.acceleration.force-enabled", true);
user_pref("gfx.canvas.azure.accelerated", true);
/* Disable restore session from crash */
user_pref("browser.sessionstore.resume_from_crash", false);
/* Disable Pocket */
user_pref("extensions.pocket.enabled", false);
/* Disable annoying Alt key */
user_pref("ui.key.menuAccessKeyFocuses", false);
/* Disable WebRTC */
user_pref("media.navigator.enabled", false);
user_pref("media.peerconnection.enabled", false);
/* Use firefox location provider */
user_pref("geo.provider.network.url", "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%");
/* Show max 5 tabs in sessionstore */
user_pref("browser.sessionstore.max_tabs_undo", 5);
/* Status of battery and clipboar */
user_pref("dom.battery.enabled", false);
user_pref("dom.event.clipboardevents.enabled", false);
/* Control sending http referer */
user_pref("network.http.referer.trimmingPolicy", 2);
/// '2' breaks vimeo
user_pref("network.http.referer.XOriginPolicy", 0);
user_pref("network.http.referer.XOriginTrimmingPolicy", 2);
/* Limit to firstparty cookies */
user_pref("privacy.firstparty.isolate", true);
/* Disables sending additional analytics to web servers */
user_pref("beacon.enabled", false);
/* Send Dont track requests */
user_pref("privacy.donottrackheader.enabled", true);
/* Disable all firefox telemetry features */
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.server", "data:,");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.coverage.opt-out", true);
user_pref("toolkit.coverage.endpoint.base", "");
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("breakpad.reportURL", "");
user_pref("browser.tabs.crashReporting.sendReport", false);
user_pref("browser.crashReports.unsubmittedCheck.enabled", false);
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);
user_pref("browser.discovery.enabled", false);
user_pref("dom.ipc.plugins.reportCrashURL", false);
/* Enable Always-on Https */
user_pref("dom.security.https_only_mode", true);
user_pref("dom.security.https_only_mode_send_http_background_request", false);
/* Disable Cloudflare DNS by user request */
user_pref("network.trr.mode", 5);
/* disable showing about:config warning */
user_pref("browser.aboutConfig.showWarning", false);
/* Disable extensions recommendations */
user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
/* Dont autoplay without user input */
user_pref("media.autoplay.blocking_policy", 2);
/* Disable Website notifications */
user_pref("dom.webnotifications.enabled", false);
/* Limit scripts from modifying windows */
user_pref("dom.disable_window_move_resize", true);
user_pref("browser.link.open_newwindow", 3);
user_pref("browser.link.open_newwindow.restriction", 0);
/* Pop-up windows */
user_pref("dom.disable_open_during_load", true);
user_pref("dom.popup_allowed_events", "click dblclick");
/* disable two javascript options */
user_pref("javascript.options.asmjs", false);
user_pref("javascript.options.wasm", false);
