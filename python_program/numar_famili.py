import requests
from bs4 import BeautifulSoup
import os
from collections import defaultdict


def fetch_family_links(url):
    response = requests.get(url)
    response.raise_for_status()
    soup = BeautifulSoup(response.text, 'html.parser')

    rows = soup.find_all("tr")

    # Dicționar pentru a stoca linkurile pentru fiecare familie
    family_links = defaultdict(list)

    for row in rows[1:]:  # Sărim peste rândul de antet
        cells = row.find_all("td")
        if cells and len(cells) > 2:
            family_name = cells[2].text.strip()
            link = cells[0].find("a")["href"] if cells[0].find("a") else None
            if link:
                link="benchmark-database.de"+link
                # stergem "?context=cnf" de la sfarsitul linkului
                link = link.split("?")[0]
                family_links[family_name].append(link)

    return family_links


def save_links_to_files(family_links, directory="family_links"):
    # Creăm directorul dacă nu există
    os.makedirs(directory, exist_ok=True)

    for family, links in family_links.items():
        # Generăm un nume de fișier valid
        # luam doar familile care au cel putin 5 linkuri
        if len(links) < 5:
            continue
        filename = f"{directory}/{family}_links.txt"
        with open(filename, mode="w") as file:
            for link in links:
                file.write(link + "\n")


# Utilizare
url = "https://benchmark-database.de/?track=main_2024"
family_links = fetch_family_links(url)
save_links_to_files(family_links)

print("Fișierele au fost create cu succes în directorul 'family_links'")
