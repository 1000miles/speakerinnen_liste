Feature: Navigation

Scenario Outline: signed in as <role>
Given you are signed in as <role>
When you view the page in <language>
Then you see <a_or_no> link labeled as: Admin

# languages are implemented in localization_steps.rb
Examples:
| language | role  | a_or_no |
| English  | admin | a       |
| German   | admin | a       |
| English  | user  | no      |
| German   | user  | no      |


Scenario Outline: viewing the admin dashboard
Given you are signed in as admin
And you view the page in <language>
When you click on: Admin
Then you are able to see: Administration
And you are able to access the admin actions in <language>

# languages are implemented in localization_steps.rb
Examples:
| language |
| English  |
| German   |


Scenario Outline: viewing edit categories in admin area
Given you view the admin dashboard in <language>
When you click on: <edit>
Then you are able to see: Administration::<area>
And you see a link labeled as: <link>
And you see a table with columns: <germanName>, <englishName>

# languages are implemented in localization_steps.rb
 Examples:
| language | link       | germanName | englishName | edit                 | area       |
| English  | Add        | German     | English     | Edit Categories      | Categories |
| German   | Hinzufügen | Deutsch    | Englisch    | Bearbeite Kategorien | Kategorien |

Scenario Outline: viewing edit profiles in admin area
Given there is a user profile registered and published with the email address: user1@example.com
And there is an admin profile registered and invisible with the email address: adm@example.com
And you view the admin dashboard in <language>
When you click on: <edit>
Then you are able to see: Administration::<area>
And you see a button labeled as: <link>
And you see a button labeled as: <link2>
And you see a table with columns: <person>, <created_at>, <media_links>, <visibility>, <roles>, <comment>
And you see a button labeled as: <link3>

# languages are implemented in localization_steps.rb
 Examples:
| language | edit              | area     | link       | link2      | link3                | person       | created_at  | media_links | visibility   | roles  | comment   |
| English  | Edit Profiles     | Profiles | public     | invisible  | Add comment          | Speakerinnen | Created at  | Media Links | Visibility   | Roles  | Comment   |
| German   | Bearbeite Profile | Profile  | öffentlich | unsichtbar | Kommentar hinzufügen | Speakerinnen | Erstellt am | Media Links | Sichtbarkeit | Rollen | Kommentar |

Scenario Outline: viewing edit certain profile in admin area
Given you view the admin area <area_action> in <language>
When you click on: <edit_link>
Then you are able to see: Administration::<area>::<area_action>
And you see a button labeled as: <update_button>
And you see a link labeled as: <show_button>
And you see a link labeled as: <show_all_button>
And you see a form with labels: <first_name>, <last_name>, <city>, <picture>, <bio>, <topic>, <topics_as_tags>

# languages are implemented in localization_steps.rb
 Examples:
| language | area     | area_action       | edit_link  | update_button            | show_button  | show_all_button     | first_name | last_name | city  | picture | bio       | topic           | topics_as_tags        |
| English  | Profiles | Edit Profiles     | Edit       | Update your profile      | Show profile | List all profiles   | First name | Last name | City  | Picture | Your bio  | Your main topic | Your topics as tags   |
| German   | Profile  | Bearbeite Profile | Bearbeiten | Aktualisiere dein Profil | Zeige Profil | Liste aller Profile | Vorname    | Nachname  | Stadt | Bild    | Deine Bio | Dein Hauptthema | Deine Themen als Tags |

Scenario Outline: viewing edit tags in admin area
Given you view the admin dashboard in <language>
When you click on: <edit>
Then you are able to see: Administration::Tags
And you are able to see: <filterTags>
And you are able to see: <noOfSearchResults>
And you see a button labeled as: <filter>

# languages are implemented in localization_steps.rb
 Examples:
| language | edit           | filterTags                      | noOfSearchResults       | filter  |
| English  | Edit Tags      | Search for tag                  | The number of tags is   | Filter  |
| German   | Bearbeite Tags | Suche nach einem bestimmtem Tag | Die Anzahl der Tags ist | Filtern |

Scenario Outline: page has header
Given you <are_or_are_not> signed in as <role>
When you view the page in <language>
Then you see the speakerinnen logo
And you see links labeled as: <links>

# languages are implemented in localization_steps.rb
Examples:
| language | are_or_are_not | role  | links                                             | 
| English  | are not        | user  | Register as a speaker, Log in, DEU                |
| English  | are            | user  | My profile, Account, Log out, DEU                 |
| English  | are            | admin | My profile, Account, Log out, Admin, DEU          |
| German   | are not        | user  | Als Speakerin registrieren, Anmelden, ENG         |
| German   | are            | user  | Mein Profil, Benutzerkonto, Ausloggen, ENG        |
| German   | are            | admin | Mein Profil, Benutzerkonto, Ausloggen, Admin, ENG |

Scenario Outline: viewing the start page
Given you are on the start page
When you view the page in <language>
Then you view the header <links> in <language>
And you are able to see sections: <titles>
And you see images labeled as: curie-photo, coaching-photo, speakerin-photo
And you see links labeled as: <links>

# languages are implemented in localization_steps.rb
Examples:
| language | titles                                                                                                                                                                                               |  links                                |
| English  | Organizers, find your speakers; Our Newest Speakers; We believe in collaboration — not competition; Our Categories; Do you have something interesting to say?; Speakerinnen*; Contact                |  Log in, Register as a speaker        |
| German   | Mehr Frauen auf die Bühnen!; Unsere neuesten Speakerinnen*; Wir glauben an Kollaboration - nicht an Wettbewerb.; Unsere Kategorien; Hast Du etwas Interessantes zu erzählen?; Speakerinnen*; Kontakt |  Anmelden, Als Speakerin registrieren |
