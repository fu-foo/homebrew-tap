"""Keeps every formula in this tap at its project's latest release.

One entry per package. The work is the same for all of them — read the latest
tag, hash the archives, rewrite the version and the checksums — so adding a
project is adding a line here rather than another workflow.
"""

import hashlib
import json
import re
import subprocess
import urllib.request

PACKAGES = [
    {
        "formula": "Formula/sazare.rb",
        "repo": "fu-foo/fhir-sazare",
        "asset": "sazare-server-{arch}.tar.gz",
        "arches": ["macos-arm64", "macos-amd64", "linux-arm64", "linux-amd64"],
    },
    {
        "formula": "Formula/fugantt.rb",
        "repo": "fu-foo/fugantt",
        "asset": "fugantt-{arch}.tar.gz",
        # No Linux arm64 build yet; the formula does not mention one either.
        "arches": ["macos-arm64", "macos-x86_64", "linux-x86_64"],
    },
]


def latest_tag(repo):
    out = subprocess.run(
        ["gh", "release", "view", "--repo", repo, "--json", "tagName"],
        capture_output=True,
        text=True,
        check=True,
    )
    return json.loads(out.stdout)["tagName"]


def sha256(url):
    with urllib.request.urlopen(url) as response:
        return hashlib.sha256(response.read()).hexdigest()


def update(package):
    path = package["formula"]
    text = open(path, encoding="utf-8").read()

    current = re.search(r'version "([^"]+)"', text).group(1)
    version = latest_tag(package["repo"]).lstrip("v")

    if version == current:
        print(f"{path}: already at {version}")
        return False

    print(f"{path}: {current} -> {version}")

    for arch in package["arches"]:
        asset = package["asset"].format(arch=arch)
        url = f"https://github.com/{package['repo']}/releases/download/v{version}/{asset}"
        digest = sha256(url)

        # The checksum that follows this architecture's url, and only that one.
        text = re.sub(
            re.escape(asset) + r'"\s*\n(\s*)sha256 "[0-9a-f]{64}"',
            lambda m: f'{asset}"\n{m.group(1)}sha256 "{digest}"',
            text,
        )

    text = re.sub(r'version "[^"]+"', f'version "{version}"', text, count=1)
    text = text.replace(f"/download/v{current}/", f"/download/v{version}/")

    open(path, "w", encoding="utf-8").write(text)
    return True


if __name__ == "__main__":
    changed = [package["formula"] for package in PACKAGES if update(package)]
    print("changed:", " ".join(changed) if changed else "nothing")
