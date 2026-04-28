# NoteFlow-App 📝

Flutter ile geliştirilmiş, kullanıcı dostu bir not kayıt uygulaması.

## 🏗️ Proje Mimarisi (Clean Architecture)

Bu projede kodun sürdürülebilirliği ve test edilebilirliği için Clean Architecture prensipleri uygulanmıştır:

- **Data:** Repository implementations, Data Sources (Hive), ve Models (JSON/Hive-Entity mapping).
- **Domain:** Entities (Saf iş nesneleri), Use Cases (İş mantığı) ve Repository Interfaces.
- **Presentation:** UI (Screens/Widgets) ve State Management (Riverpod providers).

### 🚀 Kullanılan Teknolojiler
* **Framework:** Flutter
* **Database:** [Hive](https://pub.dev/packages/hive) (Hızlı ve hafif yerel veritabanı)
* **State Management:** [Riverpod](https://riverpod.dev/) (Modern ve güvenli durum yönetimi)

### ✨ Özellikler
* Not ekleme, silme ve düzenleme.
* Tema değiştirme.
* Yerel depolama sayesinde çevrimdışı çalışma desteği.

