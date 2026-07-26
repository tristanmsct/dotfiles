import subprocess
from urllib.parse import unquote, urlparse

import gi

gi.require_version("Nautilus", "4.1")
from gi.repository import GObject, Nautilus


def uri_to_path(uri: str) -> str:
    return unquote(urlparse(uri).path)


class OpenKittyExtension(GObject.GObject, Nautilus.MenuProvider):
    def _open_kitty(self, menu, path):
        subprocess.Popen(["kitty", "--directory", path])

    def get_file_items(self, files):
        # right-click on a folder
        if len(files) != 1:
            return []
        target = files[0]
        if not target.is_directory():
            return []
        path = uri_to_path(target.get_uri())

        item = Nautilus.MenuItem(
            name="OpenKittyExtension::open_folder",
            label="Open in Kitty",
            tip=f"Open {path} in kitty",
        )
        item.connect("activate", self._open_kitty, path)
        return [item]

    def get_background_items(self, folder):
        # right-click on empty space inside a folder
        path = uri_to_path(folder.get_uri())

        item = Nautilus.MenuItem(
            name="OpenKittyExtension::open_background",
            label="Open in Kitty",
            tip=f"Open {path} in kitty",
        )
        item.connect("activate", self._open_kitty, path)
        return [item]
