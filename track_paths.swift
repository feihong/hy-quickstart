import Foundation
import iTunesLibrary

// Add a function for safe array access
extension Array {
  public func get(_ index: Int) -> Element? {
    guard index >= 0, index < endIndex else {
      return nil
    }
    return self[index]
  }
}

guard CommandLine.arguments.count >= 2 else {
  print("Please enter name of playlist you want to search for")
  exit(1)
}

if let library = try? ITLibrary(apiVersion: "1.1"), let searchName = CommandLine.arguments.get(1) {
  let playlists = library.allPlaylists

  func findPlaylist(name: String) -> ITLibPlaylist? {
    for playlist in playlists {
      if playlist.name.starts(with: name) {
        return playlist
      }
    }
    return nil
  }

  guard let playlist = findPlaylist(name: searchName) else {
    print("Did not find a playlist whose name starts with '\(searchName)'")
    exit(1)
  }

  for track in playlist.items {
    // print(track.title)
    print(track.location!.path)
  }
}
