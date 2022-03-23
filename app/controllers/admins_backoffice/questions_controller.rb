class AdminsBackoffice::QuestionsController < AdminsBackofficeController
    before_action :set_question, only: [:update, :edit, :destroy]
    before_action :get_subjects, only: [:new, :edit]

    def index
        @questions = Question.includes(:subject)
                             .order(:description)
                             .page(params[:page])
    end

    def edit
    end

    def update
        if @question.update(params_question)
            redirect_to admins_backoffice_questions_path, notice: "Perguntas atualizada com Sucesso"
        else
            render :edit
        end
    end

    def show
        
    end

    def new
        @question = Question.new
    end

    def create
        @question = Question.new(params_question)
        if @question.save()
            redirect_to admins_backoffice_questions_path, notice: "Perguntas cadastrada com Sucesso"
        else
            render :new
        end
    end

    def destroy
        if @question.destroy
            redirect_to admins_backoffice_questions_path, notice: "Perguntas excluida com Sucesso"
        else
            render :index
        end
    end

    private

    def params_question
        params_question = params.require(:question).permit(:description, :subject_id)
    end

    def set_question
        @question = Question.find(params[:id])
    end

    def get_subjects
        @subjects = Subject.all
    end
end
