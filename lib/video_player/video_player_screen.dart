import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(const VideoPlayerApp());

class VideoPlayerApp extends StatelessWidget {
  const VideoPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Player Demo',
      home: VideoPlayerScreen(),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Buat dan simpan VideoPlayerController.
    // VideoPlayerController menawarkan beberapa konstruktor berbeda
    // untuk memutar video dari aset, file, atau internet.

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
    );
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget showVideo() {
    return FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Jika VideoPlayerController telah selesai inisialisasi,
            // gunakan data yang disediakan untuk membatasi rasio aspek video.
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Gunakan widget VideoPlayer untuk menampilkan video.
              child: VideoPlayer(_controller),
            );
          } else {
            // Jika VideoPlayerController masih melakukan inisialisasi,
            // tampilkan pemutar pemuatan.
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget tombolPlay() {
    return FloatingActionButton(
      onPressed: () {
        // Selesaikan pemutaran atau jeda dalam panggilan ke `setState`.
        // Ini memastikan ikon yang benar ditampilkan.
        setState(() {
          // Jika video sedang diputar, jedakan
          if (_controller.value.isPlaying) {
            _controller.pause();
          } else {
            // Jika video sedang pause, mainkan
            _controller.play();
          }
        });
      },
      // Tampilkan ikon yang benar tergantung pada keadaan pemutar.
      child: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Butterfly'),
      ),
      body: showVideo(),
      floatingActionButton: tombolPlay(),
    );
  }
}
