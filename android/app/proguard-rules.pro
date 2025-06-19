# Keep just_audio classes
-keep class com.ryanheise.just_audio.** { *; }
-dontwarn com.ryanheise.just_audio.**

# Keep audio_session classes  
-keep class com.ryanheise.audio_session.** { *; }
-dontwarn com.ryanheise.audio_session.**

# Keep ExoPlayer classes (used by both just_audio AND video_player)
-keep class com.google.android.exoplayer2.** { *; }
-dontwarn com.google.android.exoplayer2.**

# Video Player specific rules
-keep class io.flutter.plugins.videoplayer.** { *; }
-dontwarn io.flutter.plugins.videoplayer.**

# Media3 (newer ExoPlayer versions)
-keep class androidx.media3.** { *; }
-dontwarn androidx.media3.**

# Local media and video classes
-keep class android.media.** { *; }
-keep class androidx.media.** { *; }

# Surface view for video rendering
-keep class android.view.SurfaceView { *; }
-keep class android.view.TextureView { *; }

# Video codec classes for local files
-keep class android.media.MediaCodec { *; }
-keep class android.media.MediaFormat { *; }
-keep class android.media.MediaExtractor { *; }