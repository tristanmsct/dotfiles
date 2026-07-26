import subprocess
from urllib.parse import unquote, urlparse

import gi

gi.require_version("Nautilus", "4.1")
from gi.repository import GObject, Nautilus


def uri_to_path(uri: str) -> str:
    return unquote(urlparse(uri).path)


def copy_to_clipboard(text: str):
    subprocess.run(["wl-copy"], input=text.encode())


class CopyPathExtension(GObject.GObject, Nautilus.MenuProvider):
    def _copy_path(self, menu, path):
        copy_to_clipboard(path)

    def get_file_items(self, files):
        if len(files) != 1:
            return []
        path = uri_to_path(files[0].get_uri())

        item = Nautilus.MenuItem(
            name="CopyPathExtension::copy_file_path",
            label="Copy Path",
            tip=f"Copy {path} to clipboard",
        )
        item.connect("activate", self._copy_path, path)
        return [item]

    def get_background_items(self, folder):
        path = uri_to_path(folder.get_uri())

        item = Nautilus.MenuItem(
            name="CopyPathExtension::copy_folder_path",
            label="Copy Path",
            tip=f"Copy {path} to clipboard",
        )
        item.connect("activate", self._copy_path, path)
        return [item]
