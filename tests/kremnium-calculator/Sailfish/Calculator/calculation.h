#ifndef SAILFISH_CALCULATOR_CALCULATION_H
#define SAILFISH_CALCULATOR_CALCULATION_H

#include <QAbstractListModel>
#include <QObject>
#include <QVariant>

class Calculation : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int currentIndex READ currentIndex WRITE setCurrentIndex NOTIFY currentIndexChanged)
    Q_PROPERTY(QObject* result READ result CONSTANT)
    Q_PROPERTY(QObject* focusField READ focusField CONSTANT)

public:
    enum Roles { TypeRole = Qt::UserRole + 1, TextRole, FieldRole };
    Q_ENUM(Roles)

    enum ItemType { Field = 0, Function = 1, Operation = 2 };
    Q_ENUM(ItemType)

    enum Constant { Pi = 100, E = 101 };
    Q_ENUM(Constant)

    enum Op { Add = 200, Subtract = 201, Multiply = 202, Divide = 203, Power = 204, OpenBracket = 205, CloseBracket = 206 };
    Q_ENUM(Op)

    enum Func { Sine = 300, Cosine = 301, Tangent = 302, Logarithm = 303, LogarithmBase10 = 304, Factorial = 305, SquareRoot = 306 };
    Q_ENUM(Func)

    explicit Calculation(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    int currentIndex() const { return m_currentIndex; }
    void setCurrentIndex(int idx);
    QObject* result() const { return m_result; }
    QObject* focusField() const { return m_focusField; }

    // (constants exposed as Q_ENUMs for type-level access)

    Q_INVOKABLE void insert(const QString &t);
    Q_INVOKABLE void add();
    Q_INVOKABLE void subtract();
    Q_INVOKABLE void multiply();
    Q_INVOKABLE void divide();
    Q_INVOKABLE void openBracket();
    Q_INVOKABLE void closeBracket();
    Q_INVOKABLE void changeSign();
    Q_INVOKABLE void setConstant(const QVariant &c);
    Q_INVOKABLE void factorial();
    Q_INVOKABLE void power();
    Q_INVOKABLE void sine();
    Q_INVOKABLE void cosine();
    Q_INVOKABLE void tangent();
    Q_INVOKABLE void logarithm();
    Q_INVOKABLE void logarithmBase10();
    Q_INVOKABLE void squareRoot();
    Q_INVOKABLE void paste();
    Q_INVOKABLE void backspace();
    Q_INVOKABLE void calculate();

    Q_INVOKABLE QString functionText(const QVariant &name) const;
    Q_INVOKABLE QString constantText(const QVariant &name) const;
    Q_INVOKABLE QString symbolText(const QVariant &name) const;

signals:
    void currentIndexChanged();
    void completed();
    void operationMadeToEmptyCalculation();

private:
    struct Item { int type; QString text; QVariantMap field; };
    int ensureField();
    int currentFieldIndex();
    void setFieldText(int idx, const QString &text);
    void appendOp(const QString &symbol);
    QString buildExpression() const;

    QList<Item> m_items;
    int m_currentIndex = 0;
    QObject *m_result = nullptr;
    QObject *m_focusField = nullptr;
};

#endif
