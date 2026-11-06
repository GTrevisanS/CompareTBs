from winotify import Notification

def notificarWindows(mensagem, caminhoIcon):
    notificacao = Notification(
        app_id="Opa!",
        title="CompareTBS",
        msg=mensagem,
        icon=f"{caminhoIcon}",
        duration="long"
    )
    # notificacao.add_actions(
    #     label="Abrir CompareTBs",
    #     launch="http://127.0.0.1:5000/"
    # )
    return notificacao.show()