# Documentation du Projet School

**Auteur :** Manus AI
**Date :** 1er Décembre 2025
**Projet :** `school` (Référence GitHub : [https://github.com/DkhiliFares/school](https://github.com/DkhiliFares/school))

## 1. Vue d'ensemble du Projet

Le projet `school` est une application **Spring Boot** simple qui implémente les opérations **CRUD** (Create, Read, Update, Delete) pour une entité `Student`. Il utilise **Spring Data JPA** pour la persistance des données et est configuré pour utiliser une base de données MySQL (bien que les tests unitaires utilisent des mocks pour isoler la couche de service).

Ce document se concentre sur l'implémentation des **tests unitaires** en utilisant **JUnit 5** et **Mockito**, conformément aux exigences du Travail Pratique (TP) fourni.

## 2. Configuration et Installation

Le projet a été adapté pour fonctionner dans un environnement Java 11 avec Spring Boot 2.7.18 pour assurer la compatibilité.

| Composant | Version Requise |
| :--- | :--- |
| **Java Development Kit (JDK)** | 11 |
| **Apache Maven** | 3.x |
| **Spring Boot** | 2.7.18 |
| **Dépendance JPA** | `javax.persistence` (pour Spring Boot 2.x) |

### 2.1. Étapes de Construction et de Test

1.  **Cloner le dépôt :**
    ```bash
    git clone https://github.com/DkhiliFares/school
    cd school
    ```
2.  **Exécuter les tests et construire le projet :**
    ```bash
    mvn clean install
    ```
    Cette commande compile le code source, exécute les tests unitaires (qui doivent tous réussir) et construit le fichier JAR de l'application.

## 3. Structure de l'Application

Le projet suit une architecture classique en couches pour une application Spring Boot :

| Composant | Description | Fichiers Clés |
| :--- | :--- | :--- |
| **Entity** | Modèle de données représentant la table `Student`. | `Student.java` |
| **Repository** | Interface pour les opérations de persistance des données (CRUD) via Spring Data JPA. | `StudentRepository.java` |
| **Service** | Logique métier de l'application, implémentant les opérations CRUD. | `IStudentService.java`, `StudentServiceImpl.java` |
| **Controller** | Point d'entrée REST pour l'application, gérant les requêtes HTTP. | `StudentController.java` |

## 4. Tests Unitaires avec JUnit et Mockito

Les tests unitaires se trouvent dans la classe `StudentServiceImplTest.java` et visent à valider la logique métier de la couche `Service` (`StudentServiceImpl`).

### 4.1. Configuration des Tests

Le test utilise les annotations suivantes :

*   `@ExtendWith(MockitoExtension.class)` : Active l'intégration de Mockito avec JUnit 5.
*   `@Mock` : Crée un objet **mock** de l'interface `StudentRepository`. Un mock est un objet simulé qui remplace la dépendance réelle (la base de données) pour isoler la couche de service.
*   `@InjectMocks` : Injecte l'objet mocké (`studentRepository`) dans l'instance de la classe à tester (`StudentServiceImpl`).

### 4.2. Détail des Tests Implémentés

Les tests couvrent les quatre opérations CRUD :

| Méthode Testée | Description | Mockito `when()` | Mockito `verify()` | Assertion Clé |
| :--- | :--- | :--- | :--- | :--- |
| `testGetStudents()` | Teste la récupération de tous les étudiants. | Simule le retour d'une liste d'étudiants par `studentRepository.findAll()`. | Vérifie que `findAll()` a été appelé une fois. | `Assertions.assertEquals(2, listU.size())` |
| `testRegisterStudent()` | Teste l'enregistrement d'un nouvel étudiant. | Simule le retour de l'étudiant enregistré par `studentRepository.save()`. | Vérifie que `save()` a été appelé une fois avec l'objet étudiant. | `Assertions.assertNotNull(registeredStudent)` |
| `testUpdateStudent()` | Teste la mise à jour d'un étudiant existant. | Simule `findById()` pour trouver l'étudiant, puis `save()` pour simuler la mise à jour. | Vérifie les appels à `findById()` et `save()`. | Vérifie les nouvelles valeurs des champs mis à jour. |
| `testDeleteStudent()` | Teste la suppression d'un étudiant par son ID. | Aucune simulation de retour n'est nécessaire (méthode `void`). | Vérifie que `deleteById()` a été appelé une fois avec l'ID correct. | N/A (vérification du comportement) |

**Extrait de Code (StudentServiceImplTest.java) :**

```java
// Exemple de test avec Mockito pour l'enregistrement
@Test
@Order(2)
public void testRegisterStudent() {
    // 1. Définir le comportement du mock
    Mockito.when(studentRepository.save(student)).thenReturn(student);

    // 2. Exécuter la méthode à tester
    Student registeredStudent = studentService.registerStudent(student);

    // 3. Vérifier le résultat
    Assertions.assertNotNull(registeredStudent);

    // 4. Vérifier l'interaction avec le mock (comportement)
    Mockito.verify(studentRepository, Mockito.times(1)).save(student);
}
```

## 5. Conclusion

L'implémentation des tests unitaires avec JUnit et Mockito permet de garantir la fiabilité de la logique métier dans `StudentServiceImpl` en isolant la couche de service de ses dépendances (la base de données). En utilisant des mocks pour le `StudentRepository`, nous nous assurons que les tests sont rapides, reproductibles et ne dépendent pas de l'état d'une base de données externe.

---
[1] DkhiliFares. (n.d.). *school*. GitHub. [https://github.com/DkhiliFares/school](https://github.com/DkhiliFares/school)
[2] Spring Boot. (n.d.). *Spring Boot Reference Documentation*. [https://docs.spring.io/spring-boot/docs/2.7.18/reference/html/](https://docs.spring.io/spring-boot/docs/2.7.18/reference/html/)
[3] Mockito. (n.d.). *Mockito Documentation*. [https://site.mockito.org/](https://site.mockito.org/)
